import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../minute.dart';

class CreateMinute extends StatefulWidget {
  final Meet meetApi;
  final SendMinute sendMinuteApi;
  final String meetType;

  const CreateMinute({required this.meetApi, required this.sendMinuteApi, required this.meetType, super.key});

  @override
  State<CreateMinute> createState() => _CreateMinuteState();
}

class _CreateMinuteState extends State<CreateMinute> {
  late MeetType _meet;
  final List<MeetItem> _items = [];
  bool _fail = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      await _getMeetAndItems();
    });
  }

  Future<void> _getMeetAndItems() async {
    final meet = await widget.meetApi.getMeetTypeByName(widget.meetType);
    if (meet.isError()) {
      setState(() => _fail = true);
      return;
    }

    final items = await widget.meetApi.getMeetItems(meet.tryGetSuccess()!.id);
    if (items.isError()) {
      setState(() => _fail = true);
      return;
    }
    setState(() {
      _meet = meet.tryGetSuccess()!;
      _items.clear();
      _items.addAll(items.tryGetSuccess()!);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppBloc>().state.user;

    if (_fail) {}

    if (_loading) {
      return Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
    }

    print('overload');

    return BlocProvider(
      create: (context) => MinuteBloc(items: _items, meetType: _meet, user: user, minuteSubmit: widget.sendMinuteApi),
      child: const MinuteForm(),
    );
  }
}
