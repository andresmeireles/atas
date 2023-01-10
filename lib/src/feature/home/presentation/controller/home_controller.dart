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
        final status = state.status;
        if (status == AppStatus.noCode) {
          GoRouter.of(context).go('/add-code');
          return;
        }
        if (status == AppStatus.noUser) {
          GoRouter.of(context).go('/create-user');
          return;
        }
      },
      builder: (context, state) {
        final bloc = context.read<AppBloc>();
        if (state.code == 0 || state.status == AppStatus.wrongCode) {
          bloc.add(FetchSecureCodeEvent());
          return const LoadingScreen();
        }
        if (state.code != 0 && state.user == '') {
          bloc.add(FetUserEvent());
          return const LoadingScreen();
        }
        return const Home();
      },
    );
  }
}
