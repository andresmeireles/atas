// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

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
  @override
  final int id;

  Announcement({
    required this.title,
    required this.label,
    this.dateTime,
    this.placement,
    this.observation,
    DateTime? updatedAt,
    int? id,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        id = id ?? Random().nextInt(1000);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'placement': placement,
      'observation': observation,
      'label': label.toString(),
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      title: map['title'] as String,
      dateTime: map['dateTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int) : null,
      placement: map['placement'] != null ? map['placement'] as String : null,
      observation: map['observation'] != null ? map['observation'] as String : null,
      label: MinuteLabel.values.firstWhere((e) => e.toString() == map['label'] as String),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      id: map['id'] as int,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) => Announcement.fromMap(json.decode(source) as Map<String, dynamic>);
}
