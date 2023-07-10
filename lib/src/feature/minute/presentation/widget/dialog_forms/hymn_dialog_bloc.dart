import 'package:flutter/material.dart';

import '../../../minute.dart';

/// this widget must be used under MinuteBloc widget tree
class HymnDialogBloc extends StatelessWidget {
  final MeetItem meetItem;
  final HymnItem? minuteItem;

  const HymnDialogBloc({required this.meetItem, this.minuteItem, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: minuteItem?.name);
    final number = TextEditingController(text: minuteItem?.number.toString() ?? '');

    commit() {
      Navigator.of(context).pop((Types.hymn, (name.text, int.tryParse(number.text) ?? 0)));
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
              controller: number,
              decoration: const InputDecoration(label: Text('numero')),
            ),
          ],
        ),
      ),
      commit: commit,
    );
  }
}
