import 'dart:math';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';

class MinuteForm extends StatefulWidget {
  final MinuteShape shape;

  const MinuteForm({required this.shape, super.key});

  @override
  State<MinuteForm> createState() => _MinuteFormState();
}

class _MinuteFormState extends State<MinuteForm> {
  final List<Assignment> _assign = [];

  String _generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars = 'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    final randomString = List.generate(lengthOfString, (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString;
  }

  _addAssign(Assign assign) {
    setState(() {
      _assign.add(Assignment(hash: _generateRandomString(10), assign: assign));
    });
  }

  _removeAssign(String hash) {
    setState(() {
      _assign.removeWhere((assign) => assign.hash == hash);
    });
  }

  List<Widget> _getTileIfLabelExists(Label label) {
    final assigns = _assign
        .where((element) => element.assign.label == label)
        .map(
          (e) => AssignTile(assignment: e, removeFunction: _removeAssign),
        )
        .toList();
    if (assigns.isEmpty) {
      return [const SizedBox()];
    }
    return assigns;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Center(child: Text('formulário')),
        actions: [
          IconButton(
            onPressed: () async {
              final label = await showDialog<Label?>(
                context: context,
                builder: (context) => OptionDeciderDialog(_assign.map((e) => e.assign.label).toList()),
              );
              if (label == null) return;
              final modalForm = await showDialog<(Types, dynamic)>(
                context: context,
                builder: (context) => AssignmentModalFormHandler(label),
              );
              if (modalForm == null) return;
              final (type, values) = modalForm;
              switch (type) {
                case Types.call:
                  _addAssign(Call(name: values.$1, call: values.$2, label: label));
                case Types.hym:
                  _addAssign(Hym(label: label, name: values.$1, number: values.$2));
                case Types.simpleText:
                  _addAssign(SimpleText(value: values, label: label));
              }
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.save_as)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getTileIfLabelExists(Label.presiding).first,
            _getTileIfLabelExists(Label.driving).first,
            const Text('Reconhecimentos', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(children: _getTileIfLabelExists(Label.recognition)),
            const Divider(),
            const Text('Anúncios', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(children: _getTileIfLabelExists(Label.announcement)),
            const Divider(),
            _getTileIfLabelExists(Label.firstHym).first,
            _getTileIfLabelExists(Label.regent).first,
            ..._getTileIfLabelExists(Label.fistPray),
            const Divider(),
            const Text('Chamados', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(children: _getTileIfLabelExists(Label.call)),
            const Divider(),
            const Text('Desobrigações', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(children: _getTileIfLabelExists(Label.callRelease)),
            const Divider(),
            const Text('Confirmações', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(children: _getTileIfLabelExists(Label.confirmation)),
            const Divider(),
            _getTileIfLabelExists(Label.sacramentalHym).first,
            _getTileIfLabelExists(Label.firstSpeaker).first,
            _getTileIfLabelExists(Label.secondSpeaker).first,
            _getTileIfLabelExists(Label.intermediaryHym).first,
            _getTileIfLabelExists(Label.thirdSpeaker).first,
            _getTileIfLabelExists(Label.endingHym).first,
            _getTileIfLabelExists(Label.endingPray).first,
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
