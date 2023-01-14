// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'created_minutes_bloc.dart';

enum CreatedMinuteStatus { idle, fetching, loaded, error }

class CreatedMinutesState extends Equatable {
  final List<MinuteList> minutes;
  final CreatedMinuteStatus status;

  const CreatedMinutesState({required this.minutes, required this.status});

  @override
  List<Object> get props => [minutes, status];

  CreatedMinutesState copyWith({List<MinuteList>? minutes, CreatedMinuteStatus? status}) {
    return CreatedMinutesState(minutes: minutes ?? this.minutes, status: status ?? this.status);
  }
}

class CreatedMinutesInitial extends CreatedMinutesState {
  CreatedMinutesInitial() : super(minutes: [], status: CreatedMinuteStatus.idle);
}
