// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../minute.dart';

class MeetType {
  final int id;
  final String name;
  final List<MeetItem> meetItems;
  final bool valid;

  MeetType({
    required this.id,
    required this.name,
    required this.meetItems,
    this.valid = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'meet_items': meetItems.map((x) => x.toMap()).toList(),
    };
  }

  factory MeetType.fromMap(Map<String, dynamic> map) {
    return MeetType(id: map['id'] as int, name: map['name'] as String, meetItems: []);
  }

  MeetType addItems(List<Map<String, dynamic>> items) {
    return MeetType(id: id, name: name, meetItems: items.map((e) => MeetItem.fromMap(e)).toList());
  }

  String toJson() => json.encode(toMap());

  factory MeetType.fromJson(String source) => MeetType.fromMap(json.decode(source) as Map<String, dynamic>);
}
