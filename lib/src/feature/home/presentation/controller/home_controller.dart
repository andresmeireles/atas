import 'package:atas/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../home.dart';

class HomeController extends StatelessWidget {
  const HomeController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.redirect) {
          GoRouter.of(context).go('/create-user');
        }
      },
      builder: (context, state) {
        if (state.user == '') {
          context.read<AppBloc>().add(const AddUserName());
          return const LoadingScreen();
        }
        return const Home();
      },
    );
  }
}
