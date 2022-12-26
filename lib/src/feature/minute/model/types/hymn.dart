// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class Hymn extends MinuteItem {
  final String name;
  final int number;
  final String? observation;
  @override
  final MinuteLabel label;
  @override
  final MinuteItemType type;
  @override
  final DateTime updatedAt;

  Hymn({
    required this.name,
    required this.number,
    required this.label,
    required this.type,
    this.observation,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'number': number,
      'observation': observation,
      'label': label.toString(),
      'type': type.toString(),
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Hymn.fromMap(Map<String, dynamic> map) {
    return Hymn(
      name: map['name'] as String,
      number: map['number'] as int,
      observation: map['observation'] != null ? map['observation'] as String : null,
      label: MinuteLabel.values.firstWhere((l) => l.toString() == (map['label'] as String)),
      type: MinuteItemType.values.firstWhere((t) => t.toString() == (map['type'] as String)),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Hymn.fromJson(String source) => Hymn.fromMap(json.decode(source) as Map<String, dynamic>);
}
