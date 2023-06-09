import 'package:flutter/material.dart';

import '../../../minute.dart';

class HymDialog extends StatelessWidget {
  final Label label;

  const HymDialog(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final number = TextEditingController();

    commit() {
      Navigator.of(context).pop((Types.hym, (name.text, int.tryParse(number.text) ?? 0)));
    }

    return DialogBase(
      label: label,
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
