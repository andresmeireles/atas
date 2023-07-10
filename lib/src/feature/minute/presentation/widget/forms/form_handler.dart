import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'sacramental_form.dart';
part 'sacramental_testimony_form.dart';
part 'get_tiles.dart';

/// this widget must be used under MinuteBloc widget tree
class FormHandler extends StatelessWidget {
  final String form;

  const FormHandler({required this.form, super.key});

  @override
  Widget build(BuildContext context) {
    if (form == 'sacramental') {
      return const SacramentalForm();
    }

    if (form == 'sacramental_testimony') {
      return const SacramentalTestimonyForm();
    }

    return const Placeholder();
  }
}
