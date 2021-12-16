import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'zinnia_flutter.dart';
import 'zinnia_result_entry.dart';

/// A wrapper around the zinnia's result class
class ZinniaResult {
  /// Creates instance from a pointer to a zinnia's result class.
  /// 
  /// For internal use only. Should not be used explicitly.
  ZinniaResult(this._internal);

  /// Number of results.
  int get size => ZinniaFlutter.zinniaResultSize(_internal);

  /// Returns the result by its [index].
  /// 
  /// [index] should be between 0 and [size] - 1.
  ZinniaResultEntry operator [](int index) => ZinniaResultEntry(
    ZinniaFlutter.zinniaResultValue(_internal, index).toDartString(),
    ZinniaFlutter.zinniaResultScore(_internal, index)
  );

  /// A list of results.
  List<ZinniaResultEntry> get results => List<ZinniaResultEntry>.generate(size, (index) => this[index]);

  /// Releases dynamically allocated memory.
  void dispose() {
    ZinniaFlutter.zinniaResultDestroy(_internal);
  }

  final Pointer<Void> _internal;
}