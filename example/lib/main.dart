import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zinnia_flutter/zinnia_character.dart';
import 'package:zinnia_flutter/zinnia_recognizer.dart';
import 'package:zinnia_flutter/zinnia_result_entry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _Painter _painter = _Painter();
  final ZinniaRecognizer _recognizer = ZinniaRecognizer();
  final ZinniaCharacter _character = ZinniaCharacter(300, 300);
  late final Future<bool> _initialized;
  List<ZinniaResultEntry> _results = [];

  @override
  void initState() {
    super.initState();
    _initialized = _initZinnia();
  }

  Future<bool> _initZinnia() async {
    return _recognizer
        .loadFromByteData(await rootBundle.load('assets/joyo-kanji.model'));
  }

  void _addPointToCurrentStroke(Offset point) {
    if (point.dx < 0 || point.dx > 1 || point.dy < 0 || point.dy > 1) {
      return _endStroke();
    }

    setState(() {
      _painter.currentStroke.add(point);
    });
  }

  void _endStroke() {
    if (_painter.currentStroke.isEmpty) {
      return;
    }

    var characterStroke = _painter.currentStroke
        .map((e) =>
            e.scale(_character.width.toDouble(), _character.height.toDouble()))
        .map((e) => Point<int>(e.dx.round(), e.dy.round()));

    _character.add(characterStroke);
    _results = _recognizer.classifyToList(_character, resultsLimit: 50);

    setState(() {
      _painter.strokes.add(_painter.currentStroke);
      _painter.currentStroke = [];
    });
  }

  void _clear() {
    setState(() {
      _painter.strokes.clear();
      _painter.currentStroke.clear();
      _results = [];
      _character.clear();
    });
  }

  @override
  void dispose() {
    _character.dispose();
    _recognizer.dispose();
    super.dispose();
  }

  Widget get _mainWidget {
    return LayoutBuilder(builder: (context, constraints) {
      var side = constraints.maxWidth;
      var direction = Axis.vertical;
      if (constraints.maxHeight < constraints.maxWidth) {
        side = constraints.maxHeight;
        direction = Axis.horizontal;
      }
      var size = Size(side, side);
      return Flex(
        direction: direction,
        children: [
          GestureDetector(
            onPanStart: (details) {
              _addPointToCurrentStroke(details.localPosition
                  .scale(1.0 / size.width, 1.0 / size.height));
            },
            onPanUpdate: (details) {
              _addPointToCurrentStroke(details.localPosition
                  .scale(1.0 / size.width, 1.0 / size.height));
            },
            onPanEnd: (details) {
              _endStroke();
            },
            child: CustomPaint(
              painter: _painter,
              size: size,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  var entry = _results[index];
                  return ListTile(
                    title: Text(entry.value),
                    subtitle: Text("Score: ${entry.score}"),
                  );
                }),
          ),
        ],
      );
    });
  }

  Widget get _initializationWidget {
    return const Text('Initialization...');
  }

  Widget _errorWidget(Object? error) {
    return Text("Error: $error");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: FutureBuilder(
              future: _initialized,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return _mainWidget;
                  } else {
                    return _errorWidget("initialization failed");
                  }
                } else if (snapshot.hasError) {
                  return _errorWidget(snapshot.error);
                } else {
                  return _initializationWidget;
                }
              }
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.clear),
              onPressed: _clear,
            )
          ),
    );
  }
}

class _Painter extends CustomPainter {
  List<List<Offset>> strokes = [];
  List<Offset> currentStroke = [];

  @override
  void paint(Canvas canvas, Size size) {
    var borderPaint = Paint()
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Offset.zero & size, borderPaint);

    var linePaint = Paint()
        ..strokeWidth = 5.0;

    for (var stroke in strokes) {
      canvas.drawPoints(PointMode.polygon,
          stroke.map((e) => e.scale(size.width, size.height)).toList(), linePaint);
    }

    linePaint.color = Colors.red;
    canvas.drawPoints(PointMode.polygon,
        currentStroke.map((e) => e.scale(size.width, size.height)).toList(), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
