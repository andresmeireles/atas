import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

class HymnTileBloc extends StatelessWidget {
  final HymnItem item;
  // final Function(String)? removeFunction;
  // final Function(Assignment, Assign) editFunction;

  const HymnTileBloc({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MinuteBloc>();
    final state = bloc.state;
    final isExpired = state.isExpired;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(translate(item.label), style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      // onLongPress: () async {
      //   final edit = await showDialog(
      //     context: context,
      //     builder: (context) => HymnDialog(
      //       label: hym.label,
      //       name: hym.name,
      //       number: hym.number,
      //     ),
      //   );
      //   if (edit == null) return;
      //   final (_, (name, number)) = edit;
      //   final updatedAssign = Hymn(name: name, label: hym.label, number: number);
      //   editFunction(item, updatedAssign);
      // },
      title: Text(item.name),
      subtitle: Text('N° ${item.number}'),
      trailing: isExpired
          ? null
          : IconButton(
              onPressed: () => bloc.add(RemoveAddedItem(item)),
              icon: const Icon(Icons.remove, color: Colors.red),
            ),
    );
  }
}
