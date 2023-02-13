import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeadingPresidingTile extends StatelessWidget {
  final Acknowledgment headingPresiding;

  const HeadingPresidingTile(this.headingPresiding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelText(headingPresiding.label),
        ListTile(
          title: Text(headingPresiding.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(headingPresiding.call),
          trailing: IconButton(
            onPressed: () {
              context.read<MinuteBloc>().add(RemoveItemEvent(headingPresiding));
            },
            icon: const Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}
