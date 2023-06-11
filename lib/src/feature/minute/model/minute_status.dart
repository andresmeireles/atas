enum MinuteStatus {
  draft('draft'),
  hasObligatory('has_obligatory'),
  expired('expired'),
  complete('complete');

  final String value;

  const MinuteStatus(this.value);
}
