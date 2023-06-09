import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SimpleTextTile extends StatelessWidget {
  final Assignment assignment;
  final Function(String) removeFunction;

  const SimpleTextTile({required this.assignment, required this.removeFunction, super.key});

  @override
  Widget build(BuildContext context) {
    final simpleText = assignment.assign as SimpleText;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(translate(simpleText.label.value))],
      ),
      title: Text(simpleText.value),
      trailing: IconButton(
        onPressed: () => removeFunction(assignment.hash),
        icon: const Icon(Icons.remove),
        color: Colors.red,
      ),
    );
  }
}
