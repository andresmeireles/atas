import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

final class Hym implements Assign {
  @override
  final Label label;
  final String name;
  final int number;
  final Types type;

  Hym({required this.label, required this.name, required this.number}) : type = Types.call;

  @override
  String toJson() => jsonEncode({'type': type.value, 'number': number.toString(), 'name': name, 'label': label.value});
}
