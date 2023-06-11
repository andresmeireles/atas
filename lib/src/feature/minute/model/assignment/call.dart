import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

final class Call implements Assign {
  @override
  final Label label;
  @override
  final Types type;
  final String name;
  final String call;

  Call({required this.name, required this.label, required this.call}) : type = Types.call;

  @override
  String toJson() => jsonEncode(toMap());

  @override
  Map<String, dynamic> toMap() => {'label': label.value, 'type': type.value, 'name': name, 'call': call};
}
