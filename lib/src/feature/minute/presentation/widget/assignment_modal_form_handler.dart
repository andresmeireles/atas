// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:atas/src/feature/minute/minute.dart';

// TODO: split widgets
class AssignmentModalFormHandler extends StatelessWidget {
  final Label label;

  const AssignmentModalFormHandler(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (label) {
      case Label.firstHym:
      case Label.sacramentalHym:
      case Label.intermediaryHym:
      case Label.endingHym:
        return _Hym(label);
      case Label.call:
      case Label.callRelease:
      case Label.presiding:
      case Label.driving:
      case Label.recognition:
        return _Call(label);
      default:
        return _SimpleText(label);
    }
  }
}

class _Dialog extends StatelessWidget {
  final Label label;
  final Widget content;
  final void Function() commit;

  const _Dialog({required this.label, required this.content, required this.commit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(label.value),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('voltar'),
        ),
        TextButton(onPressed: commit, child: const Text('adicionar'))
      ],
    );
  }
}

class _Hym extends StatelessWidget {
  final Label label;

  const _Hym(this.label);

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final number = TextEditingController();

    commit() {
      Navigator.of(context).pop((name.text, number.text));
    }

    return _Dialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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

class _Call extends StatelessWidget {
  final Label label;

  const _Call(this.label);

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final number = TextEditingController();

    commit() {
      Navigator.of(context).pop((name.text, number.text));
    }

    return _Dialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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

class _SimpleText extends StatelessWidget {
  final Label label;

  const _SimpleText(this.label);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
