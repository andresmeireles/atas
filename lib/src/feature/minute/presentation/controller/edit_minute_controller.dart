import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class EditMinuteController extends StatelessWidget {
  static const name = 'minute.edit';
  static const path = '/minutes/edit';

  final int minuteId;

  const EditMinuteController({required this.minuteId, super.key});

  @override
  Widget build(BuildContext context) {
    return EditMinuteForm(
      minuteId: minuteId,
      getMinuteApi: GetMinute(),
      submitMinute: EditMinute(),
      meetApi: Meet(),
    );
  }
}
