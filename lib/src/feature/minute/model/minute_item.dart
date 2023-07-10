// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atas/src/feature/minute/minute.dart';

abstract class MinuteItem {
  final String hash;
  final Types type;
  final String label;

  MinuteItem({
    required this.hash,
    required this.type,
    required this.label,
  });

  String toJson();

  Map<String, dynamic> toMap();
}
