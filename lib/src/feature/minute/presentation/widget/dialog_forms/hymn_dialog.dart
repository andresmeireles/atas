import 'package:flutter/material.dart';

import '../../../minute.dart';

class HymnDialog extends StatelessWidget {
  final Label label;
  final String? name;
  final int? number;

  const HymnDialog({required this.label, this.name, this.number, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: this.name);
    final number = TextEditingController(text: this.number?.toString() ?? '');

    commit() {
      Navigator.of(context).pop((Types.hymn, (name.text, int.tryParse(number.text) ?? 0)));
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
