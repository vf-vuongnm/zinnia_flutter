/// A wrapper around a value and a score.
class ZinniaResultEntry {
  /// Creates a instance with [value] and [score].
  ZinniaResultEntry(this.value, this.score);

  /// Value.
  final String value;
  /// Score.
  final double score;

  @override
  String toString() => "ZinniaResultEntry($value, $score)";
}