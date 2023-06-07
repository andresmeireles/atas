import 'package:atas/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final AppBar appBar;

  const AppScaffold({required this.body, required this.appBar, super.key});

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
      appBar: appBar,
      body: body,
    );
  }
}
