import 'package:atas/src/feature/minute/minute.dart';

enum Prays { first, last }

extension SelectedPray on Prays {
  MinuteLabel get label {
    switch (this) {
      case Prays.first:
        return MinuteLabel.firstPray;
      case Prays.last:
        return MinuteLabel.lastPray;
    }
  }
}
