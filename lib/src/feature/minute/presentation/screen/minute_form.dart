import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:atas/src/feature/minute/presentation/widget/option_decider_dialog.dart';
import 'package:flutter/material.dart';

class MinuteForm extends StatelessWidget {
  final MinuteShape shape;

  const MinuteForm({required this.shape, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Center(child: Text('formulário')),
        actions: [
          IconButton(
            onPressed: () async {
              final dialog = await showDialog<Label?>(
                context: context,
                builder: (context) => const OptionDeciderDialog(),
              );
              if (dialog == null) {
                return;
              }
              final modalForm = await showDialog(context: context, builder: (context) => Dialog(child: Text(dialog)));
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.save_as)),
        ],
      ),
      body: const Column(
        children: [
          Text('date'),
        ],
      ),
    );
  }
}
