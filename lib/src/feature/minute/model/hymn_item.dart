// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class HymnItem extends MinuteItem {
  final String name;
  final int number;

  HymnItem({
    required this.name,
    required this.number,
    required super.hash,
    required super.label,
  }) : super(type: Types.hymn);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'number': number,
      'type': type.value,
      'label': label,
    };
  }

  factory HymnItem.fromMap(Map<String, dynamic> map) {
    return HymnItem(
      name: map['name'] as String,
      number: map['number'] as int,
      label: map['label'] as String,
      hash: 'ok',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory HymnItem.fromJson(String source) => HymnItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
