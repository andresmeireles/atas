import 'package:atas/src/feature/minute/minute.dart';
import 'package:atas/src/feature/minute/presentation/screen/create_minute.dart';
import 'package:flutter/material.dart';

class AddMinuteController extends StatelessWidget {
  static const name = 'minutes.add';

  /// Return the path for this controller or placeholder as /minutes/add/:meetTypeId
  static path([int meetTypeId = 0]) => '/minutes/add/${meetTypeId == 0 ? ':meetTypeId' : meetTypeId}';

  final int meetTypeId;

  const AddMinuteController({required this.meetTypeId, super.key});

  @override
  Widget build(BuildContext context) {
    return CreateMinute(meetApi: Meet(), sendMinuteApi: SendMinute(), meetTypeId: meetTypeId);
  }
}
