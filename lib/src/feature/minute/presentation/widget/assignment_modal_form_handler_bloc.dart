import 'package:flutter/material.dart';

import 'package:atas/src/feature/minute/minute.dart';

class AssignmentModalFormHandlerBloc extends StatelessWidget {
  final MeetItem meetItem;

  const AssignmentModalFormHandlerBloc(this.meetItem, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (meetItem.name) {
      case 'hymn':
        return HymnDialogBloc(meetItem: meetItem);
      case 'call':
        return CallDialogBloc(meetItem: meetItem);
      default:
        return SimpleTextDialogBloc(meetItem: meetItem);
    }
  }
}
