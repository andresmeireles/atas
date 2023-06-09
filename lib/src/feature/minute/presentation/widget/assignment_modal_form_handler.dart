import 'package:flutter/material.dart';

import 'package:atas/src/feature/minute/minute.dart';

class AssignmentModalFormHandler extends StatelessWidget {
  final Label label;

  const AssignmentModalFormHandler(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (label) {
      case Label.firstHym:
      case Label.sacramentalHym:
      case Label.intermediaryHym:
      case Label.endingHym:
        return HymDialog(label);
      case Label.call:
      case Label.callRelease:
      case Label.presiding:
      case Label.driving:
      case Label.recognition:
        return CallDialog(label);
      default:
        return SimpleTextDialog(label);
    }
  }
}
