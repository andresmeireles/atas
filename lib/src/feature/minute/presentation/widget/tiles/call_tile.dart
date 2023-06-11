import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CallTile extends StatelessWidget {
  final Assignment assignment;
  final Function(String) removeFunction;
  final Function(Assignment, Assign) editFunction;

  const CallTile({required this.assignment, required this.removeFunction, required this.editFunction, super.key});

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
      onTap: () async {
        final edit = await showDialog(
          context: context,
          builder: (context) => CallDialog(
            label: call.label,
            call: call.call,
            name: call.name,
          ),
        );
        if (edit == null) return;
        final (_, (name, callName)) = edit;
        final updatedAssign = Call(name: name, label: call.label, call: callName);
        editFunction(assignment, updatedAssign);
      },
      trailing: IconButton(
        onPressed: () => removeFunction(assignment.hash),
        icon: const Icon(Icons.remove, color: Colors.red),
      ),
    );
  }
}
