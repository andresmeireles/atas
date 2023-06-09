import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CallTile extends StatelessWidget {
  final Assignment assignment;
  final Function(String) removeFunction;

  const CallTile({required this.assignment, required this.removeFunction, super.key});

  @override
  Widget build(BuildContext context) {
    final call = assignment.assign as Call;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(translate(call.label.value), style: const TextStyle(fontWeight: FontWeight.bold))],
      ),
      title: Text(call.name),
      subtitle: Text(call.call),
      trailing: IconButton(
        onPressed: () => removeFunction(assignment.hash),
        icon: const Icon(Icons.remove, color: Colors.red),
      ),
    );
  }
}
