enum MinuteTypes { sacramental }

extension Kek on MinuteTypes {
  String get name {
    switch (this) {
      case MinuteTypes.sacramental:
        return 'sacramental';
    }
  }
}
