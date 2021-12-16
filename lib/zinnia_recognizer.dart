import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'zinnia_character.dart';
import 'zinnia_result.dart';
import 'zinnia_result_entry.dart';
import 'zinnia_flutter.dart';

/// A wrapper around the zinnia's recognizer class
class ZinniaRecognizer {
  /// Loads a model from [byteData] and returns true on success.
  bool loadFromByteData(ByteData byteData) {
    return loadFromUint8List(byteData.buffer.asUint8List());
  }

  /// Loads a model from [file] and returns true on success.
  Future<bool> loadFromFile(File file) async {
    return loadFromUint8List(await file.readAsBytes());
  }

  /// Synchronously loads a model from [file] and returns true on success.
  bool loadFromFileSync(File file) {
    return loadFromUint8List(file.readAsBytesSync());
  }

  /// Loads a model from [list] and returns true on success.
  bool loadFromUint8List(Uint8List list) {
    var nativeDataPointer = _createNativeDataPointer(list.length + 1);
    var nativeData = nativeDataPointer.asTypedList(list.length + 1);
    nativeData.setAll(0, list);
    nativeData[list.length] = 0;
    
    bool result = ZinniaFlutter.zinniaRecognizerOpenFromPtr(_internal, nativeDataPointer, list.length) != 0;

    if (!result) {
      _throwException();
    }

    return result;
  }

  /// Loads a model from [fileName] and returns true on success.
  bool loadByFileName(String fileName) {
    var nativeFileName = fileName.toNativeUtf8();
    bool result = ZinniaFlutter.zinniaRecognizerOpen(_internal, nativeFileName) != 0;
    malloc.free(nativeFileName);
    return result;
  }

  /// Classifies [character] and returns [ZinniaResult]. [ZinniaResult] should be destroyed after use.
  /// 
  /// Throws an [Exception] on error.
  ZinniaResult classify(ZinniaCharacter character, { int resultsLimit = _defaultResultsLimit }) {
    var resultInternal = ZinniaFlutter.zinniaRecognizerClassify(_internal, character.internal, resultsLimit);
    if (resultInternal == nullptr) {
      _throwException();
    }
    return ZinniaResult(resultInternal);
  }

  /// Classifies [character] and returns a list of [ZinniaResultEntry].
  /// 
  /// Throws an [Exception] on error.
  List<ZinniaResultEntry> classifyToList(ZinniaCharacter character, { int resultsLimit = _defaultResultsLimit }) {
    var zinniaResult = classify(character, resultsLimit: resultsLimit);
    var results = zinniaResult.results;
    zinniaResult.dispose();
    return results;
  }

  /// Releases dynamically allocated memory.
  void dispose() {
    ZinniaFlutter.zinniaRecognizerDestroy(_internal);

    _disposeNativeDataPointer();
  }

  /// The pointer to the recognizer object.
  /// 
  /// For internal use only. Should not be used explicitly.
  Pointer<Void> get internal => _internal;

  Pointer<Uint8> _createNativeDataPointer(int byteCount) {
    _disposeNativeDataPointer();
    var nativeDataPointer = malloc<Uint8>(byteCount);
    _nativeDataPointer = nativeDataPointer;
    return nativeDataPointer;
  }

  void _disposeNativeDataPointer() {
    var nativeDataPointer = _nativeDataPointer;
    if (nativeDataPointer != null) {
      malloc.free(nativeDataPointer);
    }
  }

  void _throwException() {
    throw Exception(ZinniaFlutter.zinniaRecognizerStrerror(_internal).toDartString());
  }

  final Pointer<Void> _internal = ZinniaFlutter.zinniaRecognizerNew();

  Pointer<Uint8>? _nativeDataPointer;

  static const int _defaultResultsLimit = 10;
}