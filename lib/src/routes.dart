part of 'app.dart';

final routes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeController()),
    GoRoute(path: '/home', builder: (_, __) => const HomeController()),
    GoRoute(path: '/minutes', builder: (_, __) => const CreatedMinutesController()),
    GoRoute(path: '/create-user', builder: (_, __) => const CreateUserController()),
    GoRoute(path: '/new-minute', builder: (_, __) => const NewMinuteController()),
  ],
);
