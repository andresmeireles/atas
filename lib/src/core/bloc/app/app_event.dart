// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class BootAppEvent implements AppEvent {}

class AppLoginEvent implements AppEvent {
  final String username;
  final String password;

  AppLoginEvent({required this.username, required this.password});
}

class AppLogoutEvent implements AppEvent {}

class ToBootedEvent implements AppEvent {}
