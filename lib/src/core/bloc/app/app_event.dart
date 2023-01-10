// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class FetUserEvent extends AppEvent {}

class AddUserEvent extends AppEvent {
  final String? user;

  const AddUserEvent(this.user);
}

class ClearUserEvent extends AppEvent {
  const ClearUserEvent();
}

class FetchSecureCodeEvent extends AppEvent {}

class AddCodeEvent extends AppEvent {
  final int? code;

  const AddCodeEvent(this.code);
}
