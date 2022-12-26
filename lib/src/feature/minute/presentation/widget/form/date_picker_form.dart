import 'package:atas/src/feature/minute/minute.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DatePickerForm extends StatefulWidget {
  final SchemaItem date;

  const DatePickerForm(this.date, {super.key});

  @override
  State<DatePickerForm> createState() => _DatePickerFormState();
}

class _DatePickerFormState extends State<DatePickerForm> {
  final date = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: LabelText(widget.date.label),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DateTimePicker(
              dateMask: 'dd/MM/yyyy',
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              controller: date,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'data invalida';
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                final item = SimpleText(value: date.text, label: widget.date.label, type: widget.date.type);
                context.read<MinuteBloc>().add(AddMinuteItemEvent(item));
                context.pop();
              },
              child: const Text('adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
