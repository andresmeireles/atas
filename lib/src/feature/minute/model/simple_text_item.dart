// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class SimpleTextItem extends MinuteItem {
  final String value;

  SimpleTextItem({required this.value, required super.hash, required super.label}) : super(type: Types.simpleText);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'type': type.value,
      'label': label,
    };
  }

  factory SimpleTextItem.fromMap(Map<String, dynamic> map) {
    return SimpleTextItem(
      value: map['value'] as String,
      label: map['label'] as String,
      hash: 'ok',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SimpleTextItem.fromJson(String source) => SimpleTextItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
