part of 'created_minutes_bloc.dart';

abstract class CreatedMinutesEvent extends Equatable {
  const CreatedMinutesEvent();

  @override
  List<Object> get props => [];
}

class FetchMinutesEvent extends CreatedMinutesEvent {}
