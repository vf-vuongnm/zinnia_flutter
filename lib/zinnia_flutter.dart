import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

class ZinniaFlutter {
  static final DynamicLibrary _nativeLibrary = Platform.isAndroid
    ? DynamicLibrary.open('libzinnia_flutter.so')
    : DynamicLibrary.process();

  // zinnia_recognizer_t *zinnia_recognizer_new()
  static Pointer<Void> Function() zinniaRecognizerNew = _nativeLibrary.lookup<NativeFunction<Pointer<Void> Function()>>("zinnia_recognizer_new").asFunction();
  // void zinnia_recognizer_destroy(zinnia_recognizer_t *recognizer)
  static void Function(Pointer<Void>) zinniaRecognizerDestroy = _nativeLibrary.lookup<NativeFunction<Void Function(Pointer<Void>)>>("zinnia_recognizer_destroy").asFunction();
  // int zinnia_recognizer_open(zinnia_recognizer_t *recognizer, const char *filename)
  static int Function(Pointer<Void>, Pointer<Utf8>) zinniaRecognizerOpen = _nativeLibrary.lookup<NativeFunction<Int32 Function(Pointer<Void>, Pointer<Utf8>)>>("zinnia_recognizer_open").asFunction();
  // int zinnia_recognizer_open_from_ptr(zinnia_recognizer_t *recognizer, const char *ptr, size_t size)
  static int Function(Pointer<Void>, Pointer<Uint8>, int) zinniaRecognizerOpenFromPtr = _nativeLibrary.lookup<NativeFunction<Int32 Function(Pointer<Void>, Pointer<Uint8>, IntPtr)>>("zinnia_recognizer_open_from_ptr").asFunction();
  // int zinnia_recognizer_close(zinnia_recognizer_t *recognizer)
  static int Function(Pointer<Void>) zinniaRecognizerClose = _nativeLibrary.lookup<NativeFunction<Int32 Function(Pointer<Void>)>>("zinnia_recognizer_close").asFunction();
  // const char* zinnia_recognizer_strerror(zinnia_recognizer_t *recognizer);
  static Pointer<Utf8> Function(Pointer<Void>) zinniaRecognizerStrerror = _nativeLibrary.lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Void>)>>("zinnia_recognizer_strerror").asFunction();
  // zinnia_result_t *zinnia_recognizer_classify(zinnia_recognizer_t *recognizer, const zinnia_character_t *character, size_t nbest);
  static Pointer<Void> Function(Pointer<Void>, Pointer<Void>, int) zinniaRecognizerClassify = _nativeLibrary.lookup<NativeFunction<Pointer<Void> Function(Pointer<Void>, Pointer<Void>, IntPtr)>>("zinnia_recognizer_classify").asFunction();

  // zinnia_character_t* zinnia_character_new()
  static Pointer<Void> Function() zinniaCharacterNew = _nativeLibrary.lookup<NativeFunction<Pointer<Void> Function()>>("zinnia_character_new").asFunction();
  // void zinnia_character_destroy(zinnia_character_t *character)
  static void Function(Pointer<Void>) zinniaCharacterDestroy = _nativeLibrary.lookup<NativeFunction<Void Function(Pointer<Void>)>>("zinnia_character_destroy").asFunction();
  // void zinnia_character_set_width(zinnia_character_t *character, size_t width)
  static void Function(Pointer<Void>, int) zinniaCharacterSetWidth = _nativeLibrary.lookup<NativeFunction<Void Function(Pointer<Void>, IntPtr)>>("zinnia_character_set_width").asFunction();
  // void zinnia_character_set_height(zinnia_character_t *character, size_t height)
  static void Function(Pointer<Void>, int) zinniaCharacterSetHeight = _nativeLibrary.lookup<NativeFunction<Void Function(Pointer<Void>, IntPtr)>>("zinnia_character_set_height").asFunction();
  // size_t zinnia_character_width(zinnia_character_t *character)
  static int Function(Pointer<Void>) zinniaCharacterWidth = _nativeLibrary.lookup<NativeFunction<IntPtr Function(Pointer<Void>)>>("zinnia_character_width").asFunction();
  // size_t zinnia_character_height(zinnia_character_t *character)
  static int Function(Pointer<Void>) zinniaCharacterHeight = _nativeLibrary.lookup<NativeFunction<IntPtr Function(Pointer<Void>)>>("zinnia_character_height").asFunction();
  // void zinnia_character_clear(zinnia_character_t *stroke)
  static void Function(Pointer<Void>) zinniaCharacterClear = _nativeLibrary.lookup<NativeFunction<Void Function(Pointer<Void>)>>("zinnia_character_clear").asFunction();
  // int zinnia_character_add(zinnia_character_t *character, size_t id, int x, int y);
  static int Function(Pointer<Void>, int, int, int) zinniaCharacterAdd = _nativeLibrary.lookup<NativeFunction<Int32 Function(Pointer<Void>, IntPtr, Int32, Int32)>>("zinnia_character_add").asFunction();
  // size_t zinnia_character_strokes_size(zinnia_character_t *stroke)
  static int Function(Pointer<Void>) zinniaCharacterStrokesSize = _nativeLibrary.lookup<NativeFunction<IntPtr Function(Pointer<Void>)>>("zinnia_character_strokes_size").asFunction();

  // const char *zinnia_result_value(zinnia_result_t *result, size_t i);
  static Pointer<Utf8> Function(Pointer<Void>, int) zinniaResultValue = _nativeLibrary.lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Void>, IntPtr)>>("zinnia_result_value").asFunction();
  // float zinnia_result_score(zinnia_result_t *result, size_t i);
  static double Function(Pointer<Void>, int) zinniaResultScore = _nativeLibrary.lookup<NativeFunction<Float Function(Pointer<Void>, IntPtr)>>("zinnia_result_score").asFunction();
  // size_t zinnia_result_size(zinnia_result_t *result);
  static int Function(Pointer<Void>) zinniaResultSize = _nativeLibrary.lookup<NativeFunction<IntPtr Function(Pointer<Void>)>>("zinnia_result_size").asFunction();
  // void zinnia_result_destroy(zinnia_result_t *result);
  static void Function(Pointer<Void>) zinniaResultDestroy = _nativeLibrary.lookup<NativeFunction<Void Function(Pointer<Void>)>>("zinnia_result_destroy").asFunction();

}