import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../minute.dart';

class CreateMinute extends StatelessWidget {
  const CreateMinute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MinuteForm(
          api: SendMinute(),
          minute: Minutes(
            date: DateTime.now(),
            assignments: [],
            schema: Schema.sacramental,
            status: MinuteStatus.draft,
            user: context.read<AppBloc>().state.user,
          ),
        );
      },
    );
  }
}
