import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class SimpleTextDialogBloc extends StatelessWidget {
  final MeetItem meetItem;
  final SimpleTextItem? minuteItem;

  const SimpleTextDialogBloc({required this.meetItem, this.minuteItem, super.key});

  @override
  Widget build(BuildContext context) {
    final input = TextEditingController(text: minuteItem?.value);

    commit(BuildContext context) {
      Navigator.of(context).pop((Types.simpleText, input.text));
    }

    return DialogBaseBloc(
      label: meetItem.name,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: input,
            decoration: const InputDecoration(label: Text('valor')),
          )
        ],
      ),
      commit: () => commit(context),
    );
  }
}
