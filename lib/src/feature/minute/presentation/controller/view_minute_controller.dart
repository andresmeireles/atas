import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class ViewMinuteController extends StatelessWidget {
  static const name = 'minute.view';

  final int minuteId;

  const ViewMinuteController({required this.minuteId, super.key});

  @override
  Widget build(BuildContext context) {
    return ViewMinute(
      minuteId: minuteId,
      getMinute: GetMinute(),
    );
  }
}
