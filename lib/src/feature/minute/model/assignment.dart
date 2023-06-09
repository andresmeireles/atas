import 'package:atas/src/feature/minute/minute.dart';

final class Assignment {
  final String hash;
  final Label label;
  final Assign assign;

  Assignment({required this.hash, required this.assign}) : label = assign.label;
}
