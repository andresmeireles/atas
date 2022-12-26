// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

class AppState extends Equatable {
  final String user;
  final bool redirect;

  const AppState({required this.user, this.redirect = false});

  @override
  List<Object> get props => [user];

  AppState copyWith({String? user, bool? redirect}) {
    return AppState(user: user ?? this.user, redirect: redirect ?? this.redirect);
  }
}

class AppInitial extends AppState {
  const AppInitial() : super(user: '');
}
