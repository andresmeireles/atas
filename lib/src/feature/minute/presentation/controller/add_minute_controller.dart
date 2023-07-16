import 'package:atas/src/feature/minute/minute.dart';
import 'package:atas/src/feature/minute/presentation/screen/create_minute.dart';
import 'package:flutter/material.dart';

class AddMinuteController extends StatelessWidget {
  static const name = 'minutes.add';

  /// Return the path for this controller or placeholder as /minutes/add/:meetTypeId
  static path([String meetType = '']) => '/minutes/add/${meetType.isEmpty ? ':meetType' : meetType}';

  final String meetType;

  const AddMinuteController({required this.meetType, super.key});

  @override
  Widget build(BuildContext context) {
    return CreateMinute(meetApi: Meet(), sendMinuteApi: SendMinute(), meetType: meetType);
  }
}
