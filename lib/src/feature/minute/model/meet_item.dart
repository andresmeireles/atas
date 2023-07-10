import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class MeetItem {
  final int id;
  final String name;
  final Types type;
  final bool isRepeatable;
  final bool isObligatory;

  MeetItem({
    required this.id,
    required this.name,
    required this.type,
    required this.isRepeatable,
    required this.isObligatory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type.value,
      'isRepeatable': isRepeatable,
      'isObligatory': isObligatory,
    };
  }

  factory MeetItem.fromMap(Map<String, dynamic> map) {
    return MeetItem(
      id: map['id'] as int,
      name: map['name'] as String,
      type: Types.values.firstWhere((type) => map['type'].toString() == type.value),
      isRepeatable: map['is_repeatable'] as bool,
      isObligatory: map['is_obligatory'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetItem.fromJson(String source) => MeetItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
