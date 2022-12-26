import 'dart:convert';
import 'dart:math';

import '../minute.dart';

abstract class MinuteItem {
  DateTime get updatedAt;

  Map<String, dynamic> toMap();

  String toJson() => jsonEncode(toMap());

  MinuteItemType get type;

  MinuteLabel get label;

  String get id => Random().nextInt(1000).toString();
}
