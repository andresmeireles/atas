import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

final class Hymn implements Assign {
  @override
  final Label label;
  final String name;
  final int number;
  @override
  final Types type;

  Hymn({required this.label, required this.name, required this.number}) : type = Types.hymn;

  @override
  String toJson() => jsonEncode(toMap());

  @override
  toMap() => {'type': type.value, 'number': number.toString(), 'name': name, 'label': label.value};
}
