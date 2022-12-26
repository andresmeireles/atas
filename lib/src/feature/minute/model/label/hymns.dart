import 'package:atas/src/feature/minute/minute.dart';

enum Hymns { first, sacramental, intermediary, special, last }

extension SelectHym on Hymns {
  MinuteLabel get label {
    switch (this) {
      case Hymns.first:
        return MinuteLabel.firstHymn;
      case Hymns.sacramental:
        return MinuteLabel.sacramentalHymn;
      case Hymns.special:
        return MinuteLabel.specialHymn;
      case Hymns.intermediary:
        return MinuteLabel.intermediaryHymn;
      case Hymns.last:
        return MinuteLabel.lastHymn;
    }
  }
}
