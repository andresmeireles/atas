import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('app')),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppBloc>().add(AppLogoutEvent());
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [CardTile(route: '/minutes', icon: Icons.addchart, title: Text('Atas'))],
        ),
      ),
    );
  }
}
