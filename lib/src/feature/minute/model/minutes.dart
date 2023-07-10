// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';

class Minutes implements Submittable {
  final DateTime date;
  final Schema schema;
  final List<MinuteItem> assignments;
  final MinuteStatus status;
  final User user;
  final int? id;

  Minutes({
    required this.date,
    required this.schema,
    required this.assignments,
    required this.status,
    required this.user,
    this.id,
  });

  factory Minutes.init({required User user, required Schema schema}) {
    return Minutes(
      date: DateTime.now(),
      schema: schema,
      assignments: [],
      status: MinuteStatus.draft,
      user: user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': DateFormat('y-MM-dd').format(date),
      'schema': schema.value,
      'user': user.toMap(),
      'id': id,
      'assignments': assignments.map((assign) => assign.toMap()).toList(),
      'status': status.value,
    };
  }

  factory Minutes.fromMap(Map<String, dynamic> map) {
    final assign = map['assignments'].map((a) => AssignmentFactory.fromJsonMap(a)).toList();
    return Minutes(
      date: DateTime.parse(map['date']),
      schema: Schema.values.firstWhere((s) => s.value == map['schema'] as String),
      assignments: List<MinuteItem>.from(assign),
      status: MinuteStatus.values.firstWhere((ms) => ms.value == map['status']),
      user: User.fromMap(map['user_id'] as Map<String, dynamic>),
      id: map['id'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Minutes.fromJson(String source) => Minutes.fromMap(json.decode(source) as Map<String, dynamic>);

  Minutes copyWith({
    DateTime? date,
    Schema? schema,
    List<MinuteItem>? assignments,
    MinuteStatus? status,
    User? user,
    int? id,
  }) {
    return Minutes(
      date: date ?? this.date,
      schema: schema ?? this.schema,
      assignments: assignments ?? this.assignments,
      status: status ?? this.status,
      user: user ?? this.user,
      id: id ?? this.id,
    );
  }
}
