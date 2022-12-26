import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallForm extends StatefulWidget {
  final SchemaItem call;

  const CallForm(this.call, {super.key});

  @override
  State<CallForm> createState() => _CallFormState();
}

class _CallFormState extends State<CallForm> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final organization = TextEditingController();
  final call = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: LabelText(widget.call.label),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInput(
              controller: name,
              label: 'nome',
              validation: (String? titleValue) {
                if (titleValue == null) return 'nome necessário';
                if (titleValue.trim().isEmpty) return 'nome necessário';
                return null;
              },
            ),
            TextInput(
              controller: organization,
              label: 'organização',
              validation: (String? titleValue) {
                if (titleValue == null) return 'organização obrigatória';
                if (titleValue.trim().isEmpty) return 'organização obrigatória';
                return null;
              },
            ),
            TextInput(
              controller: call,
              label: 'chamado',
              validation: (String? titleValue) {
                if (titleValue == null) return 'chamado necessário';
                if (titleValue.trim().isEmpty) return 'chamado necessário';
                return null;
              },
            ),
            BlocBuilder<MinuteBloc, MinuteState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    final announcement = Call(
                      name: name.text,
                      organization: organization.text,
                      call: call.text,
                      label: widget.call.label,
                      type: widget.call.type,
                    );
                    context.read<MinuteBloc>().add(AddMinuteItemEvent(announcement));
                    Navigator.of(context).pop('${widget.call.label} inserido com sucesso.');
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
