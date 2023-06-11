import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SimpleTextTile extends StatelessWidget {
  final Assignment assignment;
  final Function(String) removeFunction;
  final Function(Assignment, Assign) editFunction;

  const SimpleTextTile({required this.assignment, required this.removeFunction, required this.editFunction, super.key});

  @override
  Widget build(BuildContext context) {
    final simpleText = assignment.assign as SimpleText;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(translate(simpleText.label.value))],
      ),
      onLongPress: () async {
        final edit = await showDialog(
          context: context,
          builder: (context) => SimpleTextDialog(
            label: simpleText.label,
            value: simpleText.value,
          ),
        );
        if (edit == null) return;
        final (_, value) = edit;
        final updatedAssign = SimpleText(value: value, label: simpleText.label);
        editFunction(assignment, updatedAssign);
      },
      title: Text(simpleText.value),
      trailing: IconButton(
        onPressed: () => removeFunction(assignment.hash),
        icon: const Icon(Icons.remove),
        color: Colors.red,
      ),
    );
  }
}
