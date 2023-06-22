import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../minute.dart';

class DialogBase extends StatelessWidget {
  final Label label;
  final Widget content;
  final void Function() commit;

  const DialogBase({super.key, required this.label, required this.content, required this.commit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(translate(label.value)),
      content: content,
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
