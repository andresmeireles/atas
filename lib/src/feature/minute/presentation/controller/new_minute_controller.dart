import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class NewMinuteController extends StatelessWidget {
  const NewMinuteController({super.key});

  @override
  Widget build(BuildContext context) {
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
