// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'created_minutes_bloc.dart';

enum CreatedMinuteStatus { idle, fetching, loaded, error }

class CreatedMinutesState extends Equatable {
  final List<MinuteListAggregator> minutes;
  final CreatedMinuteStatus status;
  final String? error;

  const CreatedMinutesState({required this.minutes, required this.status, this.error});

  @override
  List<Object> get props => [minutes, status];

  CreatedMinutesState copyWith({List<MinuteListAggregator>? minutes, CreatedMinuteStatus? status, String? error}) {
    return CreatedMinutesState(minutes: minutes ?? this.minutes, status: status ?? this.status, error: error);
  }
}

class CreatedMinutesInitial extends CreatedMinutesState {
  CreatedMinutesInitial() : super(minutes: [], status: CreatedMinuteStatus.idle);
}
