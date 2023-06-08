import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

final class AssignmentFactory {
  AssignmentFactory._();

  Assign fromJson(String json) {
    final decoded = jsonDecode(json);
    final type = Types.values[decoded['schema'] as int];
    switch (type) {
      case Types.call:
        return Call(call: decoded['call'], label: Label.values[decoded['label']], name: decoded['label']);
      case Types.hym:
        return Hym(name: decoded['value'], number: decoded['number'], label: Label.values[decoded['label']]);
      case Types.simpleText:
        return SimpleText(value: decoded['value'], label: Label.values[decoded['label']]);
    }
  }
}
