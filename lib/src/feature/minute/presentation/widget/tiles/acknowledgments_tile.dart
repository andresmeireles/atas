import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcknowledgmentTile extends StatelessWidget {
  final List<Acknowledgment> acknowledgments;

  const AcknowledgmentTile(this.acknowledgments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Reconhecimentos'),
        ...acknowledgments.map(
          (acknowledgment) => ListTile(
            title: Text(acknowledgment.name),
            subtitle: Text(acknowledgment.call),
            trailing: IconButton(
              onPressed: () {
                context.read<MinuteBloc>().add(RemoveItemEvent(acknowledgment));
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ),
      ],
    );
  }
}
