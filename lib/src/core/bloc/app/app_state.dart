// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

class AppState extends Equatable {
  final String token;
  final User user;
  final AppStatus status;

  const AppState({required this.token, required this.user, required this.status});

  bool isLogged() => token.isNotEmpty;

  @override
  List<Object> get props => [token, user, status];

  AppState copyWith({String? token, User? user, AppStatus? status}) {
    return AppState(user: user ?? this.user, token: token ?? this.token, status: status ?? this.status);
  }
}

class AppInitial extends AppState {
  AppInitial() : super(token: '', status: AppStatus.booting, user: User.empty());
}
