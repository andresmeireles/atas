import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class HymTile extends StatelessWidget {
  final Assignment assignment;
  final Function(String)? removeFunction;
  final Function(Assignment, Assign) editFunction;

  const HymTile({required this.assignment, this.removeFunction, required this.editFunction, super.key});

  @override
  Widget build(BuildContext context) {
    final hym = assignment.assign as Hymn;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(translate(hym.label.value), style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      onLongPress: () async {
        final edit = await showDialog(
          context: context,
          builder: (context) => HymnDialog(
            label: hym.label,
            name: hym.name,
            number: hym.number,
          ),
        );
        if (edit == null) return;
        final (_, (name, number)) = edit;
        final updatedAssign = Hymn(name: name, label: hym.label, number: number);
        editFunction(assignment, updatedAssign);
      },
      title: Text(hym.name),
      subtitle: Text('N° ${hym.number}'),
      trailing: removeFunction == null
          ? null
          : IconButton(
              onPressed: () => removeFunction!(assignment.hash),
              icon: const Icon(Icons.remove),
              color: Colors.red,
            ),
    );
  }
}
