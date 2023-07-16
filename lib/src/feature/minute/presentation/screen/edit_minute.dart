import 'dart:async';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditMinuteForm extends StatefulWidget {
  final int minuteId;
  final GetMinute getMinuteApi;
  final MinuteSubmit submitMinute;
  final Meet meetApi;

  const EditMinuteForm({
    required this.minuteId,
    required this.getMinuteApi,
    required this.submitMinute,
    required this.meetApi,
    super.key,
  });

  @override
  State<EditMinuteForm> createState() => _EditMinuteFormState();
}

class _EditMinuteFormState extends State<EditMinuteForm> {
  bool _isLoading = true;
  late Minutes _minutes;
  late MeetType _meetType;
  late List<MeetItem> _meetItems;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() => _setup());
  }

  Future<void> _setup() async {
    final requestMinute = await widget.getMinuteApi.byId(widget.minuteId);
    if (requestMinute.isError()) {
      Fluttertoast.showToast(msg: requestMinute.tryGetError()!.message);
      return;
    }
    final minute = requestMinute.tryGetSuccess()!;
    final requestMeetType = await widget.meetApi.getMeetTypeByName(minute.schema);
    if (requestMeetType.isError()) {
      Fluttertoast.showToast(msg: requestMeetType.tryGetError()!.message);
      return;
    }
    final requestMeetItems = await widget.meetApi.getMeetItems(requestMeetType.tryGetSuccess()!.id);
    if (requestMeetItems.isError()) {
      Fluttertoast.showToast(msg: requestMeetItems.tryGetError()!.message);
      return;
    }
    final meetType = requestMeetType.tryGetSuccess()!;
    final items = requestMeetItems.tryGetSuccess()!;
    setState(() {
      _isLoading = false;
      _minutes = minute;
      _meetItems = items;
      _meetType = meetType;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return _loading();

    return BlocProvider(
      create: (_) => MinuteBloc(
        user: _minutes.user,
        meetType: _meetType,
        items: _meetItems,
        addedItems: _minutes.assignments,
        minuteSubmit: widget.submitMinute,
        minutes: _minutes,
      ),
      child: const MinuteForm(),
    );
  }

  Widget _loading() => AppScaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
}
