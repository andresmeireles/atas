import 'package:atas/src/feature/minute/minute.dart';

enum Calls { call, release }

extension SelectedCall on Calls {
  MinuteLabel get label {
    switch (this) {
      case Calls.call:
        return MinuteLabel.call;
      case Calls.release:
        return MinuteLabel.callRelease;
    }
  }
}
