import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class AssignmentFactory {
  AssignmentFactory._();

  static Assign fromJson(String json) {
    final decoded = jsonDecode(json);
    return fromJsonMap(decoded);
  }

  static Assign fromJsonMap(dynamic decoded) {
    final type = Types.values.firstWhere((t) => t.value == decoded['type'].toString().toLowerCase());
    final label = Label.values.firstWhere((l) => l.value == decoded['label'].toString().toLowerCase());
    switch (type) {
      case Types.call:
        return Call(call: decoded['call'], label: label, name: decoded['name']);
      case Types.hym:
        return Hym(name: decoded['name'], number: decoded['number'], label: label);
      case Types.simpleText:
        return SimpleText(value: decoded['value'], label: label);
    }
  }
}
