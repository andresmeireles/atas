import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class AddMinuteController extends StatelessWidget {
  const AddMinuteController({super.key});

  @override
  Widget build(BuildContext context) {
    return MinuteForm(shape: SacramentalShape());
  }
}
