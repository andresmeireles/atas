import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HymnTile extends StatelessWidget {
  final Hymn hymn;
  final String label;

  const HymnTile({required this.hymn, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        ListTile(
          title: Text('${hymn.name} - n. ${hymn.number}'),
          subtitle: Text(hymn.observation ?? ''),
          trailing: IconButton(
            onPressed: () {
              context.read<MinuteBloc>().add(RemoveItemEvent(hymn));
            },
            icon: const Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}
