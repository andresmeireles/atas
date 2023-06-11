import 'package:atas/src/feature/minute/api/send_minute.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:atas/src/feature/minute/presentation/screen/create_minute.dart';
import 'package:flutter/material.dart';

class AddMinuteController extends StatelessWidget {
  static const name = 'minutes.add';
  static const path = '/minutes/add';

  const AddMinuteController({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateMinute();
  }
}
