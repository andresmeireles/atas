import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallTile extends StatelessWidget {
  final String label;
  final List<Call> calls;

  const CallTile({required this.label, required this.calls, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        ...calls.map(
          (call) => ListTile(
            title: Text(call.name),
            subtitle: Text('${call.call} da ${call.organization}'),
            trailing: IconButton(
              onPressed: () {
                context.read<MinuteBloc>().add(RemoveItemEvent(call));
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ),
      ],
    );
  }
}
