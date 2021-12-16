import 'dart:ffi';
import 'dart:math';

import 'zinnia_flutter.dart';

/// A wrapper around the zinnia's character class
class ZinniaCharacter {
  /// Creates a character instance with a size equals [width]x[height].
  ZinniaCharacter(int width, int height) {
    this.width = width;
    this.height = height;
  }

  /// Width of the character.
  int get width => ZinniaFlutter.zinniaCharacterWidth(_internal);
  /// Height of the character.
  int get height => ZinniaFlutter.zinniaCharacterHeight(_internal);

  /// Sets the width of the character.
  set width(int value) => ZinniaFlutter.zinniaCharacterSetWidth(_internal, value);
  /// Sets the height of the character.
  set height(int value) => ZinniaFlutter.zinniaCharacterSetHeight(_internal, value);

  /// Number of strokes.
  int get size => ZinniaFlutter.zinniaCharacterStrokesSize(_internal);

  /// Removes all strokes.
  void clear() {
    ZinniaFlutter.zinniaCharacterClear(_internal);
  }

  /// Adds stroke and returns true on success.
  bool add(Iterable<Point<int>> stroke) {
    var strokeIndex = size;
    for (var point in stroke) {
      if (ZinniaFlutter.zinniaCharacterAdd(_internal, strokeIndex, point.x, point.y) == 0) {
        return false;
      }
    }
    return true;
  }

  /// Releases dynamically allocated memory.
  void dispose() {
    ZinniaFlutter.zinniaCharacterDestroy(_internal);
  }

  Pointer<Void> get internal => _internal;

  final Pointer<Void> _internal = ZinniaFlutter.zinniaCharacterNew();
}