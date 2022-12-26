import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextForm extends StatefulWidget {
  final SchemaItem text;

  const TextForm(this.text, {super.key});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final formKey = GlobalKey<FormState>();
  final text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: LabelText(widget.text.label),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInput(
              controller: text,
              label: 'titulo',
              validation: (String? titleValue) {
                if (titleValue == null) return 'titulo necessário';
                if (titleValue.trim().isEmpty) return 'titulo necessário';
                text.text = titleValue;
                return null;
              },
            ),
            BlocBuilder<MinuteBloc, MinuteState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final simpleField = SimpleText(
                      value: text.text,
                      type: widget.text.type,
                      label: widget.text.label,
                    );
                    context.read<MinuteBloc>().add(AddMinuteItemEvent(simpleField));
                    Navigator.of(context).pop('${widget.text.label} adicionado');
                  },
                  child: const Text('adicionar'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
