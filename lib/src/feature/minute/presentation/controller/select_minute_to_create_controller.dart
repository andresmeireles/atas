import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class SelectMinuteToCreateController extends StatelessWidget {
  static const name = 'minute.select';
  static const path = '/minute-select';

  const SelectMinuteToCreateController({super.key});

  @override
  Widget build(BuildContext context) => SelectMinuteToCreate(meetApi: Meet());
}
