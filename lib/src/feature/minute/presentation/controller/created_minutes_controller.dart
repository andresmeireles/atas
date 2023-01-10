import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../minute.dart';

class CreatedMinutesController extends StatelessWidget {
  const CreatedMinutesController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MinuteBloc([]),
      child: const _CreatedMinutesController(),
    );
  }
}

class _CreatedMinutesController extends StatelessWidget {
  const _CreatedMinutesController();

  @override
  Widget build(BuildContext context) => const CreatedMinutes();
}
