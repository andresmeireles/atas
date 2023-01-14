import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedMinutes extends StatelessWidget {
  const CreatedMinutes({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CreatedMinutesBloc>().add(FetchMinutesEvent());
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CreatedMinutesBloc, CreatedMinutesState>(
        builder: (context, state) {
          if (state.status == CreatedMinuteStatus.fetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == CreatedMinuteStatus.error) {
            return const Text('erro ao buscar atas');
          }
          return CreatedMinuteList(state.minutes);
        },
      ),
    );
  }
}
