import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class SimpleTextDialog extends StatelessWidget {
  final Label label;

  SimpleTextDialog(this.label, {super.key});

  final value = TextEditingController();

  commit(BuildContext context) {
    Navigator.of(context).pop((Types.simpleText, value.text));
  }

  @override
  Widget build(BuildContext context) {
    return DialogBase(
      label: label,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: value,
            decoration: const InputDecoration(label: Text('valor')),
          )
        ],
      ),
      commit: () => commit(context),
    );
  }
}
