import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class CallDialogBloc extends StatelessWidget {
  final MeetItem meetItem;
  final CallItem? minuteItem;

  const CallDialogBloc({required this.meetItem, this.minuteItem, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: minuteItem?.name);
    final call = TextEditingController(text: minuteItem?.call);

    commit() {
      Navigator.of(context).pop((Types.call, (name.text, call.text)));
    }

    return DialogBaseBloc(
      label: meetItem.name,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(label: Text('nome')),
            ),
            TextField(
              controller: call,
              decoration: const InputDecoration(label: Text('chamado')),
            ),
          ],
        ),
      ),
      commit: commit,
    );
  }
}
