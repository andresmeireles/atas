import 'package:atas/src/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

// TODO: fazer validação de dados
// TODO: colocar inputs como cubit
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final user = TextEditingController();
  final password = TextEditingController();

  bool _hide = true;

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {
      user.text = 'admin';
      password.text = 'admin123';
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(child: Text('Login')),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(controller: user, decoration: const InputDecoration(label: Text('usuário'))),
                      TextField(
                        controller: password,
                        obscureText: _hide,
                        decoration: InputDecoration(
                          label: const Text('senha'),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hide = !_hide;
                                });
                              },
                              icon: Icon(_hide ? Icons.panorama_fish_eye : Icons.hide_source)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocConsumer<AppBloc, AppState>(
                        listener: (context, state) {
                          if (state.isLogged()) {
                            context.go('/');
                            return;
                          }
                          if (state.status == AppStatus.failLogin) {
                            final snackBar = SnackBar(
                              content: const Text('erro no login'),
                              action: SnackBarAction(label: 'desfazer', onPressed: () {}),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            context.read<AppBloc>().add(ToBootedEvent());
                          }
                        },
                        builder: (context, state) {
                          final bloc = context.read<AppBloc>();
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {
                              bloc.add(AppLoginEvent(username: user.text, password: password.text));
                            },
                            child: const Text('Login'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
