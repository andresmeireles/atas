import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class SimpleTextDialog extends StatelessWidget {
  final Label label;
  final String? value;

  const SimpleTextDialog({required this.label, this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final input = TextEditingController(text: value);

    commit(BuildContext context) {
      Navigator.of(context).pop((Types.simpleText, input.text));
    }

    return DialogBase(
      label: label,
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
