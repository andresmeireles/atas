import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CallTile extends StatelessWidget {
  final MinuteItem item;
  // final Function(Assignment, Assign) editFunction;
  // final Function(String)? removeFunction;

  const CallTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final call = item as CallItem;

    final bloc = context.read<MinuteBloc>();
    final state = bloc.state;
    final isExpired = state.isExpired;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(translate(call.label), style: const TextStyle(fontWeight: FontWeight.bold))],
      ),
      title: Text(call.name),
      subtitle: Text(call.call),
      // onTap: () async {
      //   final edit = await showDialog(
      //     context: context,
      //     builder: (context) => CallDialog(
      //       label: call.label,
      //       call: call.call,
      //       name: call.name,
      //     ),
      //   );
      //   if (edit == null) return;
      //   final (_, (name, callName)) = edit;
      //   final updatedAssign = Call(name: name, label: call.label, call: callName);
      //   editFunction(minuteItem, updatedAssign);
      // },
      trailing: isExpired
          ? null
          : IconButton(
              onPressed: () => bloc.add(RemoveAddedItem(item)),
              icon: const Icon(Icons.remove, color: Colors.red),
            ),
    );
  }
}
