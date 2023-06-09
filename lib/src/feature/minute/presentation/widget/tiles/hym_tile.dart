import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class HymTile extends StatelessWidget {
  final Assignment assignment;
  final Function(String) removeFunction;

  const HymTile({required this.assignment, required this.removeFunction, super.key});

  @override
  Widget build(BuildContext context) {
    final hym = assignment.assign as Hym;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(translate(hym.label.value), style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      title: Text(hym.name),
      subtitle: Text('N° ${hym.number}'),
      trailing: IconButton(
        onPressed: () => removeFunction(assignment.hash),
        icon: const Icon(Icons.remove),
        color: Colors.red,
      ),
    );
  }
}
