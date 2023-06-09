import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class CallDialog extends StatelessWidget {
  final Label label;

  const CallDialog(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final call = TextEditingController();

    commit() {
      Navigator.of(context).pop((Types.call, (name.text, call.text)));
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
              controller: call,
              decoration: const InputDecoration(label: Text('numero')),
            ),
          ],
        ),
      ),
      commit: commit,
    );
  }
}
