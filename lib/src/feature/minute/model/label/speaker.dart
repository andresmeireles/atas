import 'package:atas/src/feature/minute/minute.dart';

enum Speaker { first, second, last }

extension SelectedSpeaker on Speaker {
  MinuteLabel get label {
    switch (this) {
      case Speaker.first:
        return MinuteLabel.firstSpeaker;
      case Speaker.second:
        return MinuteLabel.secondSpeaker;
      case Speaker.last:
        return MinuteLabel.lastSpeaker;
    }
  }
}
