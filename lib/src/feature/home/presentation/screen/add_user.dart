import 'package:atas/src/feature/home/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final api = CreateUser();

    return Scaffold(
      body: Column(
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
                  onPressed: () async {
                    final router = GoRouter.of(context);
                    if (name.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('nome precisa ser preenchido')),
                      );
                      return;
                    }
                    await api.add(name.text);
                    router.go('/home');
                  },
                  child: const Text('Ok'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
