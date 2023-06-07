import 'package:atas/src/feature/auth/auth.dart';
import 'package:atas/src/feature/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

// @RoutePage(name: 'home')
class HomeController extends StatelessWidget {
  const HomeController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.status == AppStatus.booting) {
          context.read<AppBloc>().add(BootAppEvent());
          return const Loading();
        }
        if (!state.isLogged()) {
          return const Login();
        }
        return const Home();
      },
    );
  }
}
