import 'dart:convert';

import '../minute.dart';

abstract class MinuteItem {
  int get id;

  DateTime get updatedAt;

  Map<String, dynamic> toMap();

  String toJson() => jsonEncode(toMap());

  MinuteItemType get type;

  MinuteLabel get label;
}
