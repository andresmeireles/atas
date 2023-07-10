import 'dart:async';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ViewMinute extends StatefulWidget {
  final int minuteId;
  final GetMinute getMinute;

  const ViewMinute({required this.minuteId, required this.getMinute, super.key});

  @override
  State<ViewMinute> createState() => _ViewMinuteState();
}

class _ViewMinuteState extends State<ViewMinute> {
  bool _loading = true;
  late Minutes _minute;

  @override
  void initState() {
    super.initState();
    widget.getMinute.byId(widget.minuteId).then((value) {
      value.when(
        (success) {
          scheduleMicrotask(() => _setMinute(success));
        },
        (error) => context.pop(),
      );
    });
  }

  _setMinute(Minutes minute) {
    setState(() {
      _loading = false;
      _minute = minute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: _loading ? const Text('visualizar') : _titleRow),
      body: _loading ? _load : _view,
    );
  }

  get _titleRow => Column(
        children: [const Text('Reunião Sacramental'), Text(DateFormat('d/MM/y').format(_minute.date))],
      );

  get _view {
    return const Placeholder();
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 5),
    //   child: ListView(
    //     children: [
    //       const SizedBox(height: 8),
    //       _callRow(label: Label.presiding),
    //       _callRow(label: Label.driving),
    //       const SizedBox(height: 20),
    //       if (_getMultiples(Label.recognition, Types.call).isNotEmpty)
    //         ..._multipleRow(name: 'Reconhecimento', label: Label.recognition, type: Types.call),
    //       if (_getMultiples(Label.announcement, Types.simpleText).isNotEmpty)
    //         ..._multipleRow(name: 'Anúncios', label: Label.announcement, type: Types.simpleText),
    //       _hymnRow(label: Label.firstHymn, placeholderText: 'primeiro hino'),
    //       _simpleRow(label: Label.fistPray, placeholderText: 'primeira oração'),
    //       if (_getMultiples(Label.call, Types.call).isNotEmpty)
    //         ..._multipleRow(name: 'Chamados', label: Label.call, type: Types.call),
    //       if (_getMultiples(Label.callRelease, Types.call).isNotEmpty)
    //         ..._multipleRow(name: 'Desobrigação', label: Label.callRelease, type: Types.call),
    //       _hymnRow(label: Label.sacramentalHym, placeholderText: 'hino sacramental'),
    //       const SizedBox(height: 20),
    //       _leadingText('Sacramento'),
    //       const SizedBox(height: 20),
    //       _simpleRow(label: Label.firstSpeaker, placeholderText: 'primeiro orador'),
    //       _simpleRow(label: Label.secondSpeaker),
    //       _hymnRow(label: Label.intermediaryHym, placeholderText: 'Hino Intermediário'),
    //       _simpleRow(label: Label.thirdSpeaker, placeholderText: 'ultimo orador'),
    //       _hymnRow(label: Label.endingHymn, placeholderText: 'hino de encerramento'),
    //       _simpleRow(label: Label.endingPray, placeholderText: 'oração de encerramento'),
    //       const SizedBox(height: 30),
    //     ],
    //   ),
    // );
  }

  _leadingText(String text) {
    return Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15));
  }

  // Widget _callRow({required Label label, String? placeholderText, int size = 30}) {
  //   final call = _getSingleCall(label);
  //   if (call == null) return Text(placeholderText ?? 'preencher');
  //   final textArea = translate(call.label.value);
  //   return ListTile(
  //     leading: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [Text('$textArea:'.padRight(size - textArea.length))],
  //     ),
  //     title: Text(call.name),
  //     subtitle: Text(call.call),
  //   );
  // }

  // Widget _simpleRow({required Label label, String? placeholderText, int size = 30}) {
  //   final simple = _getSingleSimple(label);
  //   if (simple == null) return Text(placeholderText ?? 'preencher');
  //   final text = translate(simple.label.value);
  //   return ListTile(
  //     leading: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [Text('$text:'.padRight(size - text.length))],
  //     ),
  //     title: Text(simple.value),
  //   );
  // }

  // _hymnRow({required Label label, String? placeholderText, int size = 30}) {
  //   final hymn = _getSingleHymn(label);
  //   if (hymn == null) return Text(placeholderText ?? 'preencher');
  //   final text = translate(hymn.label.value);
  //   return ListTile(
  //     leading: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [Text('$text:'.padRight(size - text.length))],
  //     ),
  //     title: Text(hymn.name),
  //     trailing: Text('Nº ${hymn.number}'),
  //   );
  // }

  // List<Widget> _multipleRow({required String name, required Label label, required Types type}) {
  //   return [
  //     _leadingText(name),
  //     const SizedBox(height: 10),
  //     SizedBox(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: _getMultiples(label, type).map((e) {
  //           if (e.type == Types.call) {
  //             final c = e as Call;
  //             return Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Text(c.name.padRight(35 - c.name.length)),
  //                     Text(c.call),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //               ],
  //             );
  //           }
  //           final s = e as SimpleText;
  //           return Text(s.value, style: const TextStyle(fontSize: 16));
  //         }).toList(),
  //       ),
  //     ),
  //     const Divider(thickness: 2),
  //   ];
  // }

  get _load => const Center(child: CircularProgressIndicator());

  List<MinuteItem> _getMultiples(Label label, Types type) {
    return _minute.assignments.where((e) => e.label == label.value && e.type == type).toList();
  }

  // MinuteItem? _getSingle(Label label, Types type) {
  //   final results = _minute.assignments.where((e) => e.label == label.value && e.type == type);
  //   if (results.isEmpty) return null;
  //   return results.first;
  // }
}
