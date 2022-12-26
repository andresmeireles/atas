import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../minute.dart';

class HymForm extends StatefulWidget {
  final SchemaItem hymn;

  const HymForm(this.hymn, {super.key});

  @override
  State<HymForm> createState() => _HymFormState();
}

class _HymFormState extends State<HymForm> {
  final formKey = GlobalKey<FormState>();
  final hymName = TextEditingController();
  final hymNumber = TextEditingController();
  final observation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: LabelText(widget.hymn.label),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInput(
              controller: hymName,
              label: 'hino',
              validation: (String? titleValue) {
                if (titleValue == null) return 'titulo necessário';
                if (titleValue.trim().isEmpty) return 'titulo necessário';
                hymName.text = titleValue;
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: hymNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('numero'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                validator: (String? titleValue) {
                  if (titleValue == null) return 'numero obrigatório';
                  if (titleValue.trim().isEmpty) return 'numero obrigatório';
                  return null;
                },
              ),
            ),
            TextInput(
              controller: observation,
              label: 'observação',
            ),
            BlocBuilder<MinuteBloc, MinuteState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final hym = Hymn(
                      name: hymName.text,
                      number: int.parse(hymNumber.text),
                      observation: observation.text,
                      type: widget.hymn.type,
                      label: widget.hymn.label,
                    );
                    context.read<MinuteBloc>().add(AddMinuteItemEvent(hym));
                    Navigator.of(context).pop('${widget.hymn.label} adicionado');
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
