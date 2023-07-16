import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/auth/auth.dart';
import 'package:atas/src/feature/home/home.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(create: (_) => AppBloc(Auth()), child: const _App());
}

// final _appRouter = AppRouter().config();

final _routes = GoRouter(
  routes: [
    GoRoute(name: HomeController.name, path: HomeController.path, builder: (_, __) => const HomeController()),
    GoRoute(name: AuthController.name, path: AuthController.path, builder: (_, __) => const AuthController()),
    GoRoute(
      path: AddMinuteController.path(),
      builder: (_, state) {
        return AddMinuteController(meetType: state.pathParameters['meetType'].toString());
      },
    ),
    GoRoute(
      name: SelectMinuteToCreateController.name,
      path: SelectMinuteToCreateController.path,
      builder: (_, __) => const SelectMinuteToCreateController(),
    ),
    GoRoute(
      name: MinuteListController.name,
      path: MinuteListController.path,
      builder: (_, __) => const MinuteListController(),
    ),
    GoRoute(
      name: EditMinuteController.name,
      path: '${EditMinuteController.path}/:id',
      builder: (_, state) => EditMinuteController(minuteId: int.parse(state.pathParameters['id'].toString())),
    ),
    GoRoute(
      name: ViewMinuteController.name,
      path: '${MinuteListController.path}/:id',
      builder: (_, state) => ViewMinuteController(minuteId: int.parse(state.pathParameters['id'].toString())),
    ),
  ],
);

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp.router(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        title: 'Atas',
        routerConfig: _routes,
      ),
    );
  }
}
