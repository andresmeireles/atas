// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

class AppState extends Equatable {
  final String token;
  final AppStatus status;

  const AppState({required this.token, required this.status});

  bool isLogged() => token.isNotEmpty;

  @override
  List<Object> get props => [token, status];

  AppState copyWith({String? token, AppStatus? status}) {
    return AppState(token: token ?? this.token, status: status ?? this.status);
  }
}

class AppInitial extends AppState {
  const AppInitial() : super(token: '', status: AppStatus.booting);
}
