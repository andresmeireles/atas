import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';

class Minutes {
  final DateTime date;
  final Schema schema;
  final User? user;
  final List<Assign> assignments;

  Minutes({required this.date, required this.schema, this.user, required this.assignments});
}
