import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';

class AddSecurityCode extends StatelessWidget {
  const AddSecurityCode({super.key});

  @override
  Widget build(BuildContext context) {
    final code = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('adicione o código de verificação')),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state.status == AppStatus.ok) {
            GoRouter.of(context).go('/home');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: code,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('adicione o código'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                ),
                if (state.status == AppStatus.wrongCode) const Text('código errado ou invalido.'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AppBloc>().add(AddCodeEvent(int.tryParse(code.text)));
                    },
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
