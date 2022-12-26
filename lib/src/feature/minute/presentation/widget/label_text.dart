import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final MinuteLabel label;

  const LabelText(this.label, {super.key});

  @override
  Widget build(BuildContext context) => Text(LocalizeLabel().label(label));
}
