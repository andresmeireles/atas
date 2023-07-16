part of 'view_form_handler.dart';

class Sacramental extends StatelessWidget {
  final Minutes minute;

  const Sacramental({required this.minute, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          _callRow(label: Label.presiding),
          _callRow(label: Label.driving),
          const SizedBox(height: 20),
          if (_getMultiples(Label.recognition, Types.call).isNotEmpty)
            ..._multipleRow(name: 'Reconhecimento', label: Label.recognition, type: Types.call),
          if (_getMultiples(Label.announcement, Types.simpleText).isNotEmpty)
            ..._multipleRow(name: 'Anúncios', label: Label.announcement, type: Types.simpleText),
          _hymnRow(label: Label.firstHymn, placeholderText: 'primeiro hino'),
          _simpleRow(label: Label.fistPray, placeholderText: 'primeira oração'),
          if (_getMultiples(Label.call, Types.call).isNotEmpty)
            ..._multipleRow(name: 'Chamados', label: Label.call, type: Types.call),
          if (_getMultiples(Label.callRelease, Types.call).isNotEmpty)
            ..._multipleRow(name: 'Desobrigação', label: Label.callRelease, type: Types.call),
          _hymnRow(label: Label.sacramentalHym, placeholderText: 'hino sacramental'),
          const SizedBox(height: 20),
          _leadingText('Sacramento'),
          const SizedBox(height: 20),
          _simpleRow(label: Label.firstSpeaker, placeholderText: 'primeiro orador'),
          _simpleRow(label: Label.secondSpeaker),
          _hymnRow(label: Label.intermediaryHym, placeholderText: 'Hino Intermediário'),
          _simpleRow(label: Label.thirdSpeaker, placeholderText: 'ultimo orador'),
          _hymnRow(label: Label.endingHymn, placeholderText: 'hino de encerramento'),
          _simpleRow(label: Label.endingPray, placeholderText: 'oração de encerramento'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _callRow({required Label label, String? placeholderText, int size = 30}) {
    final call = _getSingleCall(label);
    if (call == null) return Text(placeholderText ?? 'preencher');
    final textArea = translate(call.label);
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('$textArea:'.padRight(size - textArea.length))],
      ),
      title: Text(call.name),
      subtitle: Text(call.call),
    );
  }

  CallItem? _getSingleCall(Label label) => _getSingle(label, Types.call) as CallItem?;

  Widget _simpleRow({required Label label, String? placeholderText, int size = 30}) {
    final simple = _getSingleSimple(label);
    if (simple == null) return Text(placeholderText ?? 'preencher');
    final text = translate(simple.label);
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('$text:'.padRight(size - text.length))],
      ),
      title: Text(simple.value),
    );
  }

  SimpleTextItem? _getSingleSimple(Label label) => _getSingle(label, Types.simpleText) as SimpleTextItem?;

  _hymnRow({required Label label, String? placeholderText, int size = 30}) {
    final hymn = _getSingleHymn(label);
    if (hymn == null) return Text(placeholderText ?? 'preencher');
    final text = translate(hymn.label);
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('$text:'.padRight(size - text.length))],
      ),
      title: Text(hymn.name),
      trailing: Text('Nº ${hymn.number}'),
    );
  }

  HymnItem? _getSingleHymn(Label label) => _getSingle(label, Types.hymn) as HymnItem?;

  MinuteItem? _getSingle(Label label, Types type) {
    final results = minute.assignments.where((e) => e.label == label.value && e.type == type);
    if (results.isEmpty) return null;
    return results.first;
  }

  List<MinuteItem> _getMultiples(Label label, Types type) {
    return minute.assignments.where((e) => e.label == label.value && e.type == type).toList();
  }

  List<Widget> _multipleRow({required String name, required Label label, required Types type}) {
    return [
      _leadingText(name),
      const SizedBox(height: 10),
      SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _getMultiples(label, type).map((e) {
            if (e.type == Types.call) {
              final c = e as CallItem;
              return Column(
                children: [
                  Row(
                    children: [
                      Text(c.name.padRight(35 - c.name.length)),
                      Text(c.call),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }
            final s = e as SimpleTextItem;
            return Text(s.value, style: const TextStyle(fontSize: 16));
          }).toList(),
        ),
      ),
      const Divider(thickness: 2),
    ];
  }

  _leadingText(String text) {
    return Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15));
  }
}
