part of 'form_handler.dart';

/// This widget must be used under MinuteBloc widget tree
class SacramentalForm extends StatelessWidget {
  const SacramentalForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinuteBloc, MinuteState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              ListTile(
                onTap: state.minute.id != null
                    ? null
                    : () async {
                        final date = await showDialog<DateTime?>(
                          context: context,
                          builder: (context) {
                            return DatePickerDialog(
                              initialDate: state.minute.date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2035),
                            );
                          },
                        );
                        print(date);
                        if (date == null) return;
                        context.read<MinuteBloc>().add(UpdateMinuteDateEvent(date: date));
                      },
                title: Text(DateFormat('dd/MM/yyyy').format(state.minute.date), textAlign: TextAlign.center),
                subtitle: const Text('data da reunião', textAlign: TextAlign.center),
              ),
              ListTile(
                title: Text('editado por ${state.minute.user.name}', textAlign: TextAlign.center),
              ),
              _singleCallItem(context, Label.presiding.value),
              _singleCallItem(context, Label.driving.value),
              const Text('Reconhecimentos', style: TextStyle(fontWeight: FontWeight.bold)),
              Column(children: _multipleCallItem(context, Label.recognition.value)),
              const Divider(),
              const Text('Anúncios', style: TextStyle(fontWeight: FontWeight.bold)),
              Column(children: _multipleSimpleTextItem(context, Label.announcement.value)),
              const Divider(),
              _singleHymnItem(context, Label.firstHymn.value),
              _singleSimpleTextItem(context, Label.regent.value),
              _singleSimpleTextItem(context, Label.fistPray.value),
              const Divider(),
              const Text('Chamados', style: TextStyle(fontWeight: FontWeight.bold)),
              Column(children: _multipleCallItem(context, Label.call.value)),
              const Divider(),
              const Text('Desobrigações', style: TextStyle(fontWeight: FontWeight.bold)),
              Column(children: _multipleCallItem(context, Label.callRelease.value)),
              const Divider(),
              const Text('Confirmações', style: TextStyle(fontWeight: FontWeight.bold)),
              Column(children: _multipleSimpleTextItem(context, Label.confirmation.value)),
              const Divider(),
              _singleHymnItem(context, Label.sacramentalHym.value),
              _singleSimpleTextItem(context, Label.firstSpeaker.value),
              _singleSimpleTextItem(context, Label.secondSpeaker.value),
              _singleHymnItem(context, Label.intermediaryHym.value),
              _singleSimpleTextItem(context, Label.thirdSpeaker.value),
              _singleHymnItem(context, Label.endingHymn.value),
              _singleSimpleTextItem(context, Label.endingPray.value),
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }
}
