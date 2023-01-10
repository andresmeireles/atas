// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

class AppState extends Equatable {
  final String user;
  final int code;
  final AppStatus status;

  const AppState({required this.user, required this.code, required this.status});

  @override
  List<Object> get props => [user, code, status];

  AppState copyWith({String? user, int? code, AppStatus? status}) {
    return AppState(user: user ?? this.user, code: code ?? this.code, status: status ?? this.status);
  }
}

class AppInitial extends AppState {
  const AppInitial() : super(user: '', code: 0, status: AppStatus.checking);
}
