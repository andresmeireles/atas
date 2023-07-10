import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

/// This widget must be used under a MinuteBloc Provider widget tree
class OptionDeciderDialog extends StatelessWidget {
  const OptionDeciderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final state = context.read<MinuteBloc>().state;
    final items = state.items;
    final addedItems = state.addedItems;
    items.sort(((a, b) => a.name.compareTo(b.name)));

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Adicionar Novo'),
          IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () => Navigator.of(context).pop()),
        ],
      ),
      content: SizedBox(
        width: width * 0.7,
        height: double.infinity,
        child: ListView(children: items.map((label) => _item(context, label, addedItems)).toList()),
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('fechar'))],
    );
  }

  Widget _item(BuildContext context, MeetItem item, List<MinuteItem> addedItems) {
    final notAdded = addedItems.where((ai) => ai.label == item.name).isEmpty;
    final isRepeatable = item.isRepeatable;
    return ListTile(
      onTap: notAdded || isRepeatable ? () => Navigator.of(context).pop(item) : null,
      leading: !notAdded && !isRepeatable ? const Icon(Icons.check) : const Icon(Icons.add),
      title: Text(translate(item.name)),
      subtitle: item.isObligatory ? const Text('Campo obrigatório') : null,
    );
  }
}
