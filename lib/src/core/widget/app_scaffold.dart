import 'package:atas/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final AppBar appBar;
  final Widget body;
  final Widget? floatingActionButton;

  const AppScaffold({required this.appBar, required this.body, this.floatingActionButton, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.status == AppStatus.loggedOut) {
          context.go('/login');
        }
      },
      child: _scaffold,
    );
  }

  Widget get _scaffold {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      body: body,
    );
  }
}
