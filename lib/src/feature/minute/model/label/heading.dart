import 'package:atas/src/feature/minute/minute.dart';

enum Heading { heading, presiding }

extension SelectAcknowledgment on Heading {
  MinuteLabel get label {
    switch (this) {
      case Heading.heading:
        return MinuteLabel.heading;
      case Heading.presiding:
        return MinuteLabel.presiding;
    }
  }
}
