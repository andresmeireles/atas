import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class OptionDeciderDialog extends StatelessWidget {
  const OptionDeciderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: const Text('adicionar novo'),
      content: SizedBox(
        width: width * 0.7,
        height: double.infinity,
        child: ListView(children: Label.values.map((label) => _item(context, label)).toList()),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('fechar')),
      ],
    );
  }

  Widget _item(BuildContext context, Label label) {
    return ListTile(
      title: Text(label.value),
      onTap: () => Navigator.of(context).pop(label),
    );
  }
}
