import 'package:flutter/material.dart';

class TextMinuteItem extends StatelessWidget {
  final String label;
  final String value;

  const TextMinuteItem({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}
