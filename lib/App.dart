import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/auth/auth.dart';
import 'package:atas/src/feature/home/home.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(create: (_) => AppBloc(Auth()), child: const _App());
}

// final _appRouter = AppRouter().config();

final _routes = GoRouter(
  routes: [
    GoRoute(name: '/', path: '/', builder: (_, __) => const HomeController()),
    GoRoute(name: '/login', path: '/login', builder: (_, __) => const AuthController()),
    GoRoute(name: '/minutes', path: '/minutes', builder: (_, __) => const MinuteListController()),
  ],
);

class _App extends StatelessWidget {
  const _App();

  // final _routes = GoRouter(
  //   routes: [
  //     GoRoute(name: '/', path: '/', builder: (_, __) => const HomeController()),
  //     GoRoute(name: '/login', path: '/login', builder: (_, __) => const AuthController()),
  //     GoRoute(name: '/minutes', path: '/minutes', builder: (_, __) => const MinuteListController()),
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   routeInformationParser: _routes.routeInformationParser,
    //   routeInformationProvider: _routes.routeInformationProvider,
    //   routerDelegate: _routes.routerDelegate,
    //   backButtonDispatcher: RootBackButtonDispatcher(),
    //   title: 'Atas',
    // );

    return MaterialApp.router(routerConfig: _routes, title: 'Atas');
  }
}
