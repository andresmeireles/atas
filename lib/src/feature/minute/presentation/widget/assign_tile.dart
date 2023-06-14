import 'package:atas/src/feature/minute/minute.dart';
import 'package:atas/src/feature/minute/presentation/widget/tiles/_export.dart';
import 'package:flutter/material.dart';

class AssignTile extends StatelessWidget {
  final Assignment assignment;
  final Function(String) removeFunction;
  final Function(Assignment, Assign) editFunction;

  const AssignTile({required this.assignment, required this.removeFunction, required this.editFunction, super.key});

  @override
  Widget build(BuildContext context) {
    final type = assignment.assign.type;
    switch (type) {
      case Types.call:
        return CallTile(assignment: assignment, removeFunction: removeFunction, editFunction: editFunction);
      case Types.hymn:
        return HymTile(assignment: assignment, removeFunction: removeFunction, editFunction: editFunction);
      case Types.simpleText:
        return SimpleTextTile(assignment: assignment, removeFunction: removeFunction, editFunction: editFunction);
    }
  }
}
