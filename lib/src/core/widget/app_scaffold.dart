import 'dart:developer';

import 'package:atas/src/feature/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatefulWidget {
  final AppBar appBar;
  final Widget body;
  final Widget? floatingActionButton;

  const AppScaffold({required this.appBar, required this.body, this.floatingActionButton, super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Auth().check().then((value) {
      value.when(
        (success) => setState(() => _loading = false),
        (error) {
          log(error.toString());
          context.go('/login');
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      appBar: widget.appBar,
      body: _loading ? _loadingWidget : widget.body,
    );
  }

  Widget get _loadingWidget => const Center(child: CircularProgressIndicator());
}
