// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:atas/src/core/utils/export.dart';
import 'package:atas/src/feature/minute/minute.dart';

class CallItem extends MinuteItem {
  final String name;
  final String call;

  CallItem({
    required this.name,
    required this.call,
    required super.hash,
    required super.label,
  }) : super(type: Types.call);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'call': call,
      'type': type.value,
      'label': label,
    };
  }

  factory CallItem.fromMap(Map<String, dynamic> map) {
    return CallItem(
      name: map['name'] as String,
      call: map['call'] as String,
      label: map['label'] as String,
      hash: generateRandomString(10),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory CallItem.fromJson(String source) => CallItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
