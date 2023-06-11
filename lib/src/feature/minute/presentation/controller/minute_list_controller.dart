import 'package:atas/src/feature/minute/api/get_minute.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class MinuteListController extends StatelessWidget {
  static const name = 'minutes';
  static const path = '/minutes';

  const MinuteListController({super.key});

  @override
  Widget build(BuildContext context) => MinuteDashboard(GetMinute());
}