import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../minute.dart';

class CreateMinute extends StatefulWidget {
  final Meet meetApi;
  final SendMinute sendMinuteApi;
  final int meetTypeId;

  const CreateMinute({required this.meetApi, required this.sendMinuteApi, required this.meetTypeId, super.key});

  @override
  State<CreateMinute> createState() => _CreateMinuteState();
}

class _CreateMinuteState extends State<CreateMinute> {
  late MeetType _meet;
  final List<MeetItem> _items = [];
  bool _fail = false;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      await _getMeetAndItems();
    });
  }

  Future<void> _getMeetAndItems() async {
    final meet = await widget.meetApi.getMeetTypeById(widget.meetTypeId);
    final items = await widget.meetApi.getMeetItems(widget.meetTypeId);
    if (meet.isError() && items.isError()) {
      setState(() => _fail = true);
      return;
    }
    setState(() {
      _meet = meet.tryGetSuccess()!;
      _items.clear();
      _items.addAll(items.tryGetSuccess()!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppBloc>().state.user;

    return MinuteForm(
      api: widget.sendMinuteApi,
      minute: Minutes(
        date: DateTime.now(),
        assignments: [],
        schema: Schema.sacramental,
        status: MinuteStatus.draft,
        user: user,
      ),
    );
  }
}
