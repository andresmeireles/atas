import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SimpleTextTile extends StatelessWidget {
  final SimpleTextItem item;
  // final Function(String)? removeFunction;
  // final Function(Assignment, Assign) editFunction;

  const SimpleTextTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MinuteBloc>();
    final state = bloc.state;
    final isExpired = state.isExpired;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(translate(item.label))],
      ),
      // onLongPress: () async {
      //   final edit = await showDialog(
      //     context: context,
      //     builder: (context) => SimpleTextDialog(
      //       label: item.label,
      //       value: simpleText.value,
      //     ),
      //   );
      //   if (edit == null) return;
      //   final (_, value) = edit;
      //   final updatedAssign = SimpleText(value: value, label: simpleText.label);
      //   editFunction(item, updatedAssign);
      // },
      title: Text(item.value),
      trailing: isExpired
          ? null
          : IconButton(
              onPressed: () => bloc.add(RemoveAddedItem(item)),
              icon: const Icon(Icons.remove, color: Colors.red),
            ),
    );
  }
}
