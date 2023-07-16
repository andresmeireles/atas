import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

part 'sacramental.dart';
part 'sacramental_testimony.dart';

class ViewFormHandler extends StatelessWidget {
  final Minutes minute;

  const ViewFormHandler({required this.minute, super.key});

  @override
  Widget build(BuildContext context) {
    switch (minute.schema) {
      case 'sacramental':
        return Sacramental(minute: minute);
      case 'sacramental_testimony':
        return SacramentalTestimony(minute: minute);
      default:
        return Sacramental(minute: minute);
    }
  }
}
