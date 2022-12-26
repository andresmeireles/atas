import 'package:atas/src/feature/minute/minute.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementForm extends StatefulWidget {
  final SchemaItem announcement;

  const AnnouncementForm(this.announcement, {super.key});

  @override
  State<AnnouncementForm> createState() => _AnnouncementFormState();
}

class _AnnouncementFormState extends State<AnnouncementForm> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final place = TextEditingController();
  final dateTime = TextEditingController();
  final observation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: LabelText(widget.announcement.label),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInput(
              controller: title,
              label: 'titulo',
              validation: (String? titleValue) {
                if (titleValue == null) return 'titulo necessário';
                if (titleValue.trim().isEmpty) return 'titulo necessário';
                title.text = titleValue;
                return null;
              },
            ),
            TextInput(controller: place, label: 'local'),
            _dateInput(controller: dateTime, label: 'Data e hora do evento'),
            TextInput(controller: observation, label: 'observações'),
            BlocBuilder<MinuteBloc, MinuteState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    final date = DateTime.tryParse(dateTime.text);
                    final announcement = Announcement(
                      title: title.text,
                      dateTime: date,
                      label: widget.announcement.label,
                      placement: place.text.isEmpty ? null : place.text,
                      observation: observation.text.isEmpty ? null : observation.text,
                    );
                    context.read<MinuteBloc>().add(AddMinuteItemEvent(announcement));
                    Navigator.of(context).pop('anuncio adicionado');
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

  Widget _dateInput({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validation,
  }) {
    final d = DateTime.now();
    final h = TimeOfDay.now();
    final dt = DateTime(d.year, d.month, d.day, h.hour, h.minute);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DateTimePicker(
        type: DateTimePickerType.dateTime,
        initialDate: dt,
        firstDate: d.subtract(const Duration(days: 1)),
        lastDate: d.add(const Duration(days: 365)),
        controller: controller,
        decoration: InputDecoration(
          label: const Text('Selecione a data'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        validator: validation,
      ),
    );
  }
}
