import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class Acknowledgment extends MinuteItem {
  final String name;
  final String call;
  @override
  final MinuteLabel label;
  @override
  final MinuteItemType type;
  @override
  final DateTime updatedAt;

  Acknowledgment({
    required this.name,
    required this.call,
    required this.label,
    required this.type,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'call': call,
      'label': label.toString(),
      'type': type.toString(),
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Acknowledgment.fromMap(Map<String, dynamic> map) {
    return Acknowledgment(
      name: map['name'] as String,
      call: map['call'] as String,
      label: MinuteLabel.values.firstWhere((element) => element.toString() == (map['label'] as String)),
      type: MinuteItemType.values.firstWhere((element) => element.toString() == (map['type'] as String)),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Acknowledgment.fromJson(String source) => Acknowledgment.fromMap(json.decode(source) as Map<String, dynamic>);
}
