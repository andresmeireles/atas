import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

const repeatable = [
  Label.call,
  Label.callRelease,
  Label.announcement,
  Label.recognition,
  Label.confirmation,
  Label.presentingChild
];

class OptionDeciderDialog extends StatelessWidget {
  final List<Label> labels;
  final MinuteShape shape;

  const OptionDeciderDialog({required this.shape, required this.labels, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final labels = [...shape.obligatory, ...shape.optional];

    return AlertDialog(
      title: const Text('adicionar novo'),
      content: SizedBox(
        width: width * 0.7,
        height: double.infinity,
        child: ListView(children: labels.map((label) => _item(context, label)).toList()),
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('fechar'))],
    );
  }

  Widget _item(BuildContext context, Label label) {
    final active = labels.contains(label);
    final isRepeatable = repeatable.contains(label);
    return TextButton(
      onPressed: !active || isRepeatable ? () => Navigator.of(context).pop(label) : null,
      child: Text(translate(label.value)),
    );
  }
}
