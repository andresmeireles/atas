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
      appBar: AppBar(title: const Text('visualizar')),
      body: _loading ? _load : _view,
    );
  }

  get _view {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text('Reunião Sacramental'),
          Row(
            children: [
              Text('Data: ${DateFormat('d/MM/y').format(_minute.date)}'),
            ],
          ),
          const Text('Reconhecimentos'),
          Column(
            children: _getMultiples(Label.recognition, Types.call).map((e) {
              final c = e as Call;
              return Text('${c.name} - ${c.call}');
            }).toList(),
          )
        ],
      ),
    );
  }

  get _load => const Center(child: CircularProgressIndicator());

  List<Assign> _getMultiples(Label label, Types type) {
    return _minute.assignments.where((e) => e.label == label && e.type == type).toList();
  }
}
