# zinnia_flutter

A dart wrapper around zinnia library.

[Zinnia](https://taku910.github.io/zinnia/) ([日本語](https://taku910.github.io/zinnia/index-ja.html)) is a simple, customizable and portable online hand recognition system based on Support Vector Machines.
It can be used to recognize handwritten Japanese characters (漢字).

Model files can be found [here](https://tegaki.github.io/).

## Example

```dart
var modelByteData = await rootBundle.load('assets/joyo-kanji.model');
var recognizer = ZinniaRecognizer()
    ..loadFromByteData(modelByteData);

var character = ZinniaCharacter(100, 100);
character.add([const Point(10, 50), const Point(90, 50)]);
character.add([const Point(50, 10), const Point(50, 90)]);

var list = recognizer.classifyToList(character, resultsLimit: 3);
/*
    list == [
        ZinniaResultEntry('十', 0.5172672867774963),
        ZinniaResultEntry('七', -0.3905687928199768),
        ZinniaResultEntry('斗', -0.5770313143730164)
    ]
*/

character.dispose();
recognizer.dispose();
```

Flutter application example can be found [here](example).

## License

License information for this wrapper, zinnia and model files can be found in [LICENSE](LICENSE) file.