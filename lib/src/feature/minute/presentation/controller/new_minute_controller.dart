import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class NewMinuteController extends StatelessWidget {
  final String? editingMinute;

  const NewMinuteController({this.editingMinute, super.key});

  factory NewMinuteController.editing(String minuteName) {
    return NewMinuteController(editingMinute: minuteName);
  }

  @override
  Widget build(BuildContext context) {
    if (editingMinute != null) {
      return _editing(context);
    }
    return _create(context);
  }

  Widget _editing(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (_, state) {
        return BlocProvider(create: (_) => MinuteBloc([]), child: EditMinute(editingMinute!));
      },
    );
  }

  Widget _create(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (_, state) {
        final items = [
          SimpleText(value: state.user, label: MinuteLabel.createdBy, type: MinuteItemType.text),
          SimpleText(value: DateTime.now().toString(), label: MinuteLabel.createdAt, type: MinuteItemType.date),
          SimpleText(value: DateTime.now().toString(), label: MinuteLabel.meetingDate, type: MinuteItemType.date),
        ];
        return BlocProvider(create: (_) => MinuteBloc(items), child: const NewMinute());
      },
    );
  }
}
