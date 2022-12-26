// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class Call extends MinuteItem {
  final String name;
  final String organization;
  final String call;
  @override
  final MinuteLabel label;
  @override
  final MinuteItemType type;
  @override
  final DateTime updatedAt;

  Call({
    required this.name,
    required this.organization,
    required this.call,
    required this.label,
    required this.type,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'organization': organization,
      'call': call,
      'label': label.toString(),
      'type': type.toString(),
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      name: map['name'] as String,
      organization: map['organization'] as String,
      call: map['call'] as String,
      label: MinuteLabel.values.firstWhere((element) => element.toString() == (map['label'] as String)),
      type: MinuteItemType.values.firstWhere((item) => item.toString() == (map['type'] as String)),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Call.fromJson(String source) => Call.fromMap(json.decode(source) as Map<String, dynamic>);
}
