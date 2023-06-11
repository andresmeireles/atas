import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditMinuteForm extends StatefulWidget {
  final int minuteId;
  final GetMinute getMinuteApi;
  final EditMinute editMinute;

  const EditMinuteForm({required this.minuteId, required this.getMinuteApi, required this.editMinute, super.key});

  @override
  State<EditMinuteForm> createState() => _EditMinuteFormState();
}

class _EditMinuteFormState extends State<EditMinuteForm> {
  bool _isLoading = true;
  late Minutes _minutes;

  @override
  void initState() {
    widget.getMinuteApi.byId(widget.minuteId).then((value) {
      value.when(
        (success) {
          setState(() {
            _isLoading = false;
            _minutes = success;
          });
        },
        (error) => Fluttertoast.showToast(msg: error.message),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? _loading() : MinuteForm(minute: _minutes, api: widget.editMinute);
  }

  Widget _loading() => AppScaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
}
