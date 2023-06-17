import 'package:flutter/material.dart';

import 'package:atas/src/feature/minute/minute.dart';

class AssignmentModalFormHandler extends StatelessWidget {
  final Label label;

  const AssignmentModalFormHandler(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (label) {
      case Label.firstHymn:
      case Label.sacramentalHym:
      case Label.intermediaryHym:
      case Label.endingHymn:
        return HymnDialog(label: label);
      case Label.call:
      case Label.callRelease:
      case Label.presiding:
      case Label.driving:
      case Label.recognition:
        return CallDialog(label: label);
      default:
        return SimpleTextDialog(label: label);
    }
  }
}
