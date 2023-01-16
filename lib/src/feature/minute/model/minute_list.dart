import 'dart:convert';

import '../minute.dart';

class MinuteList {
  final String name;
  final MinuteMode status;

  MinuteList({required this.name, required this.status});

  Map<String, dynamic> toMap() => <String, dynamic>{'name': name, 'status': status.toString()};

  factory MinuteList.fromMap(Map<String, dynamic> map) {
    return MinuteList(
      name: map['name'] as String,
      status: MinuteMode.values.firstWhere((element) => element.toString() == (map['status'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory MinuteList.fromJson(String source) => MinuteList.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MinuteListAggregator {
  final String id;
  final MinuteList minute;

  MinuteListAggregator({
    required this.id,
    required this.minute,
  });
}
