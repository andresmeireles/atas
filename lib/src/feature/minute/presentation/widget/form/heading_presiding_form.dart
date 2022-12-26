import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeadingPresidingForm extends StatefulWidget {
  final SchemaItem headingPresiding;

  const HeadingPresidingForm(this.headingPresiding, {super.key});

  @override
  State<HeadingPresidingForm> createState() => _HeadingPresidingFormState();
}

class _HeadingPresidingFormState extends State<HeadingPresidingForm> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final call = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: LabelText(widget.headingPresiding.label),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInput(
              controller: name,
              label: 'nome',
              validation: (String? titleValue) {
                if (titleValue == null) return 'nome obrigatório';
                if (titleValue.trim().isEmpty) return 'nome obrigatório';
                return null;
              },
            ),
            TextInput(
              controller: call,
              label: 'chamado',
              validation: (String? titleValue) {
                if (titleValue == null) return 'chamado obrigatório';
                if (titleValue.trim().isEmpty) return 'chamado obrigatório';
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
                    final headingPresiding = Acknowledgment(
                      name: name.text,
                      call: call.text,
                      label: widget.headingPresiding.label,
                      type: widget.headingPresiding.type,
                    );
                    context.read<MinuteBloc>().add(AddMinuteItemEvent(headingPresiding));
                    Navigator.of(context).pop('item adicionado com sucesso');
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
