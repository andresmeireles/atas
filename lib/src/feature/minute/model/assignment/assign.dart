import 'package:atas/src/feature/minute/minute.dart';

abstract class Assign {
  String toJson();

  Map<String, dynamic> toMap();

  Label get label;

  Types get type;
}
