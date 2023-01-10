import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedMinutes extends StatelessWidget {
  const CreatedMinutes({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MinuteBloc>().add(GetExistingMinuteEvent());
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MinuteBloc, MinuteState>(
        builder: (context, state) {
          if (state.status == MinuteStatus.fetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == MinuteStatus.errorOnFetching) {
            return const Text('non ok');
          }
          return Text(state.status.name);
        },
      ),
    );
  }

  // Widget _minutesList(List<Minute> minutes) {
  //   return ListView.builder(
  //     itemCount: minutes.length,
  //     itemBuilder: (context, index) {
  //       final minute = minutes[index];
  //       return ListTile(title: Text('Ata do dia ${minute.createdAt}'));
  //     },
  //   );
  // }
}
