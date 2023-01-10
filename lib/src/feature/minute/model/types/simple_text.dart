// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:atas/src/feature/minute/minute.dart';

class SimpleText extends MinuteItem {
  final String value;
  @override
  final MinuteLabel label;
  @override
  final MinuteItemType type;
  @override
  final DateTime updatedAt;
  @override
  final int id;

  SimpleText({
    required this.value,
    required this.label,
    required this.type,
    DateTime? updatedAt,
    int? id,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        id = id ?? Random().nextInt(1000);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'label': label.toString(),
      'type': type.toString(),
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory SimpleText.fromMap(Map<String, dynamic> map) {
    return SimpleText(
      value: map['value'] as String,
      label: MinuteLabel.values.firstWhere((e) => e.toString() == map['label'] as String),
      type: MinuteItemType.values.firstWhere((e) => e.toString() == map['type'] as String),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      id: map['id'] as int,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SimpleText.fromJson(String source) => SimpleText.fromMap(json.decode(source) as Map<String, dynamic>);
}
