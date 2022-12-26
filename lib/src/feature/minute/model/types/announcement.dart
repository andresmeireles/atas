// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:atas/src/feature/minute/minute.dart';

class Announcement extends MinuteItem {
  final String title;
  final DateTime? dateTime;
  final String? placement;
  final String? observation;
  @override
  final MinuteLabel label;
  @override
  final type = MinuteItemType.announcement;
  @override
  final DateTime updatedAt;

  Announcement({
    required this.title,
    required this.label,
    this.dateTime,
    this.placement,
    this.observation,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'placement': placement,
      'observation': observation,
      'label': label.toString(),
      'type': type.toString(),
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      title: map['title'] as String,
      label: MinuteLabel.values.firstWhere((element) => element.toString() == (map['label'] as String)),
      dateTime: map['dateTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int) : null,
      placement: map['placement'] != null ? map['placement'] as String : null,
      observation: map['observation'] != null ? map['observation'] as String : null,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) => Announcement.fromMap(json.decode(source) as Map<String, dynamic>);
}
