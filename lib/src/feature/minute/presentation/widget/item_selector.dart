import 'package:flutter/material.dart';

import '../../minute.dart';

class ItemSelector extends StatelessWidget {
  final List<SchemaItem> minuteItems;
  final List<MinuteLabel> minuteAddedLabels;

  const ItemSelector({required this.minuteItems, required this.minuteAddedLabels, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('adicionar a ata'),
      content: Column(children: minuteItems.map((e) => _itemButton(context, e)).toList()),
    );
  }

  Widget _itemButton(BuildContext context, SchemaItem schemaItem) {
    if (schemaItem.repeatable) {
      return _addButton(context, schemaItem);
    }
    if (minuteAddedLabels.contains(schemaItem.label)) {
      return _addButton(context, schemaItem, active: false);
    }
    return _addButton(context, schemaItem);
  }

  Widget _addButton(BuildContext context, SchemaItem item, {bool active = true}) {
    return active
        ? TextButton(onPressed: () => Navigator.of(context).pop(item), child: LabelText(item.label))
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(LocalizeLabel().label(item.label), style: const TextStyle(color: Colors.grey)),
          );
  }
}
