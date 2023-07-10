import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class AssignmentFactory {
  AssignmentFactory._();

  static MinuteItem fromJson(String json) {
    final decoded = jsonDecode(json);
    return fromJsonMap(decoded);
  }

  static MinuteItem fromJsonMap(dynamic decoded) {
    final type = Types.values.firstWhere((t) => t.value == decoded['type'].toString().toLowerCase());
    switch (type) {
      case Types.call:
        return CallItem.fromMap(decoded);
      case Types.hymn:
        return HymnItem.fromMap(decoded);
      case Types.simpleText:
        return SimpleTextItem.fromMap(decoded);
    }
  }
}
