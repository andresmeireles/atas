import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();

    return Scaffold(
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state.status == AppStatus.ok) {
            GoRouter.of(context).go('/home');
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text('qual é o seu nome?'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: name,
                        decoration: const InputDecoration(label: Text('nome')),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AppBloc>().add(AddUserEvent(name.text));
                      },
                      child: const Text('Ok'),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
