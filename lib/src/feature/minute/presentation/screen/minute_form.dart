import 'dart:math';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class MinuteForm extends StatefulWidget {
  final Minutes minute;
  final MinuteSubmit api;

  const MinuteForm({required this.minute, required this.api, super.key});

  @override
  State<MinuteForm> createState() => _MinuteFormState();
}

class _MinuteFormState extends State<MinuteForm> {
  final List<Assignment> _assign = [];

  @override
  void initState() {
    super.initState();
    _assign.addAll(widget.minute.assignments.map((e) => Assignment(hash: const Uuid().v4(), assign: e)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final (foreground, background) = _colorByStatus(widget.minute.status);
    return AppScaffold(
      appBar: AppBar(
        foregroundColor: foreground,
        backgroundColor: background,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Nova ${translate(widget.minute.schema.value)}'),
              Text(translate(widget.minute.status.value)),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _showDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              final minute = Minutes(
                id: widget.minute.id,
                user: widget.minute.user,
                assignments: _assign.map((a) => a.assign).toList(),
                date: widget.minute.date,
                schema: widget.minute.schema,
                status: widget.minute.status,
              );
              final submit = await widget.api.submit(minute);
              submit.when(
                (success) {
                  Fluttertoast.showToast(msg: 'Ata criada com sucesso', gravity: ToastGravity.BOTTOM);
                  context.pushReplacementNamed(MinuteListController.name);
                },
                (error) {
                  Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.BOTTOM);
                },
              );
            },
            icon: const Icon(Icons.save_as),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            ListTile(
              title: Text(DateFormat('dd/MM/yyyy').format(widget.minute.date), textAlign: TextAlign.center),
              subtitle: const Text('data da reunião', textAlign: TextAlign.center),
            ),
            ListTile(
              title: Text('editado por ${widget.minute.user.name}', textAlign: TextAlign.center),
            ),
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

  (Color, Color) _colorByStatus(MinuteStatus status) {
    switch (status) {
      case MinuteStatus.draft:
        return (Colors.black, Colors.yellow);
      case MinuteStatus.complete:
        return (Colors.white, Colors.green);
      case MinuteStatus.expired:
        return (Colors.white, Colors.brown.shade300);
      case MinuteStatus.hasObligatory:
        return (Colors.white, Colors.blueAccent);
    }
  }

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

  _showDialog(BuildContext context) async {
    final label = await showDialog<Label?>(
      context: context,
      builder: (context) => OptionDeciderDialog(
        shape: widget.minute.schema.shape,
        labels: _assign.map((e) => e.assign.label).toList(),
      ),
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
  }
}
