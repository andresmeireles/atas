import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToAdd extends StatelessWidget {
  final SchemaInterface schema;

  const ToAdd(this.schema, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinuteBloc, MinuteState>(
      builder: (context, state) {
        final missingItems = schema.missing(state.items).when((success) => <MinuteLabel>[], (error) => error);
        final icon = missingItems.isEmpty ? Icons.check : Icons.warning_amber_rounded;
        return IconButton(
          onPressed: () {
            showDialog(context: context, builder: (_) => _showMissing(missingItems));
          },
          icon: Icon(icon),
        );
      },
    );
  }

  Widget _showMissing(List<MinuteLabel> missingItems) {
    return AlertDialog(
      title: const Text('parâmetros obrigatórios', textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: missingItems.isEmpty
            ? const [Text('Todos os parâmetros obrigatórios foram preenchidos', textAlign: TextAlign.center)]
            : missingItems.map((e) => Text(e.descriptionName)).toList(),
      ),
    );
  }
}
