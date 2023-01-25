class MinuteNotExistsException implements Exception {
  final String minute;

  MinuteNotExistsException(this.minute);

  @override
  String toString() => 'ata não existe';
}
