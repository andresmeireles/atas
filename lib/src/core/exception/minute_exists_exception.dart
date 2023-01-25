class MinuteExistsException implements Exception {
  final String minuteName;

  MinuteExistsException(this.minuteName);

  @override
  String toString() => 'ata $minuteName já existe';
}
