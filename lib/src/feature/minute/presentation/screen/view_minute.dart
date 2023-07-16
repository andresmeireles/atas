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

  get _view => ViewFormHandler(minute: _minute);

  get _load => const Center(child: CircularProgressIndicator());
}
