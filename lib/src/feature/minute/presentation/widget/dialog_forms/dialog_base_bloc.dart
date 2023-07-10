import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DialogBaseBloc extends StatelessWidget {
  final String label;
  final Widget content;
  final void Function() commit;

  const DialogBaseBloc({super.key, required this.label, required this.content, required this.commit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(translate(label)),
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
