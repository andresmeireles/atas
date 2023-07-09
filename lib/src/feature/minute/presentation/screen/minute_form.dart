import 'dart:math';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// loaders para quando o botão de salvar for pressionado
class MinuteForm extends StatefulWidget {
  final Minutes minute;
  final MinuteSubmit api;
  final List<MeetItem> minuteAssignments;

  const MinuteForm({required this.minute, required this.api, this.minuteAssignments = const [], super.key});

  @override
  State<MinuteForm> createState() => _MinuteFormState();
}

class _MinuteFormState extends State<MinuteForm> {
  final List<Assignment> minuteAssignments = [];
  DateTime _minuteDate = DateTime.now();
  bool _submitting = false;
  late bool isExpired;

  @override
  void initState() {
    super.initState();
    isExpired = widget.minute.status == MinuteStatus.expired;
    minuteAssignments
        .addAll(widget.minute.assignments.map((e) => Assignment(hash: const Uuid().v4(), assign: e)).toList());
    _minuteDate = widget.minute.date;
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
        actions: _submitting
            ? [
                const Center(
                  child: Padding(padding: EdgeInsets.only(right: 15.0), child: CircularProgressIndicator()),
                ),
              ]
            : isExpired
                ? []
                : [
                    IconButton(onPressed: () async => await _showDialog(context), icon: const Icon(Icons.add)),
                    IconButton(onPressed: () async => await _submitMinute(), icon: const Icon(Icons.save_as)),
                  ],
      ),
      body: _submitting
          ? _submitWidget
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  ListTile(
                    title: Text(DateFormat('dd/MM/yyyy').format(_minuteDate), textAlign: TextAlign.center),
                    subtitle: const Text('data da reunião', textAlign: TextAlign.center),
                    onTap: widget.minute.id == null ? () => _changeDate(context) : null,
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
                  _getTileIfLabelExists(Label.firstHymn).first,
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
                  _getTileIfLabelExists(Label.endingHymn).first,
                  _getTileIfLabelExists(Label.endingPray).first,
                  const SizedBox(height: 100),
                ],
              ),
            ),
    );
  }

  Future<void> _submitMinute() async {
    setState(() => _submitting = true);
    final minute = Minutes(
      id: widget.minute.id,
      user: widget.minute.user,
      assignments: minuteAssignments.map((a) => a.assign).toList(),
      date: _minuteDate,
      schema: widget.minute.schema,
      status: widget.minute.status,
    );
    final submit = await widget.api.submit(minute);
    submit.when(
      (success) {
        Fluttertoast.showToast(msg: 'Ata criada com sucesso', gravity: ToastGravity.BOTTOM);
        context.pop();
        context.pushReplacement(MinuteListController.path);
      },
      (error) {
        Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.BOTTOM);
        setState(() => _submitting = true);
      },
    );
  }

  Future<void> _changeDate(BuildContext context) async {
    final dt = await showDatePicker(
      context: context,
      initialDate: _minuteDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (dt == null) return;
    setState(() => _minuteDate = dt);
  }

  Widget get _submitWidget {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('enviando...'), SizedBox(height: 10), LinearProgressIndicator()],
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
    setState(() => minuteAssignments.add(Assignment(hash: _generateRandomString(10), assign: assign)));
  }

  _removeAssign(String hash) => setState(() => minuteAssignments.removeWhere((assign) => assign.hash == hash));

  List<Widget> _getTileIfLabelExists(Label label) {
    final assigns = minuteAssignments
        .where((element) => element.assign.label == label)
        .map(
          (e) =>
              AssignTile(assignment: e, removeFunction: isExpired ? null : _removeAssign, editFunction: _editFunction),
        )
        .toList();
    if (assigns.isEmpty) return [const SizedBox()];

    return assigns;
  }

  _editFunction(Assignment assignment, Assign assign) {
    minuteAssignments.removeWhere((element) => element.hash == assignment.hash);
    setState(() => minuteAssignments.add(Assignment(hash: assignment.hash, assign: assign)));
  }

  _showDialog(BuildContext context) async {
    final label = await showDialog<Label?>(
      context: context,
      builder: (context) => OptionDeciderDialog(
        shape: widget.minute.schema.shape,
        labels: minuteAssignments.map((e) => e.assign.label).toList(),
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
        break;
      case Types.hymn:
        _addAssign(Hymn(label: label, name: values.$1, number: values.$2));
        break;
      case Types.simpleText:
        _addAssign(SimpleText(value: values, label: label));
        break;
    }
  }
}
