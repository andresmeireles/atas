import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleTextTile extends StatelessWidget {
  final SimpleText simpleText;
  final bool fixed;

  const SimpleTextTile(this.simpleText, {this.fixed = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelText(simpleText.label),
        ListTile(
          title: Text(simpleText.value),
          trailing: fixed
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    context.read<MinuteBloc>().add(RemoveItemEvent(simpleText));
                  },
                  icon: const Icon(Icons.close),
                ),
        ),
      ],
    );
  }
}
