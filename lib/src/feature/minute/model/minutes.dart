import 'dart:convert';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:intl/intl.dart';

class Minutes implements Submittable {
  final DateTime date;
  final Schema schema;
  final List<Assign> assignments;
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
    final List assignments = jsonDecode(map['assignments']);
    return Minutes(
      date: DateTime.parse(map['date']),
      schema: Schema.values.firstWhere((s) => s.value == map['schema'] as String),
      assignments: assignments.map((a) => AssignmentFactory.fromJsonMap(a)).toList(),
      status: MinuteStatus.values.firstWhere((ms) => ms.value == map['status']),
      user: User.fromMap(map['user_id'] as Map<String, dynamic>),
      id: map['id'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Minutes.fromJson(String source) => Minutes.fromMap(json.decode(source) as Map<String, dynamic>);
}
