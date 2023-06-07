import 'package:atas/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// @RoutePage(name: 'minutes')
class MinuteListController extends StatelessWidget {
  const MinuteListController({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('atas'), actions: [
        IconButton(
          onPressed: () {
            context.read<AppBloc>().add(AppLogoutEvent());
          },
          icon: const Icon(Icons.exit_to_app),
        ),
      ]),
      body: const Text('campos'),
    );
  }
}
