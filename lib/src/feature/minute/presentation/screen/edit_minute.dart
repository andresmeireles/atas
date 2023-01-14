import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMinute extends StatelessWidget {
  final String minute;

  const EditMinute(this.minute, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MinuteBloc>();
    bloc.add(GetExistingMinuteEvent(name: minute));
    return const NewMinute();
  }
}
