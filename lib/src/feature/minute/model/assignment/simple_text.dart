import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

final class SimpleText implements Assign {
  @override
  final Label label;
  final String value;
  final Types type;

  SimpleText({required this.value, required this.label}) : type = Types.simpleText;

  @override
  String toJson() => jsonEncode({'label': label.value, 'type': type.value, 'value': value});
}
