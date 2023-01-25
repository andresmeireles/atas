part of 'minute_bloc.dart';

enum MinuteMode { creating, draw, updating, ready, closed }

extension Names on MinuteMode {
  String get label => describeEnum(this);

  String get name {
    switch (this) {
      case MinuteMode.closed:
        return 'fechado';
      case MinuteMode.draw:
        return 'rascunho';
      case MinuteMode.ready:
        return 'pronto';
      case MinuteMode.updating:
        return 'atualizando';
      case MinuteMode.creating:
        return 'criando';
    }
  }
}
