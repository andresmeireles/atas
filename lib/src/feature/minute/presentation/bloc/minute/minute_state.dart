// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'minute_bloc.dart';

class MinuteState extends Equatable {
  final List<MinuteItem> items;
  final MinuteStatus status;
  final MinuteMode mode;
  final String? error;

  const MinuteState({
    required this.items,
    required this.status,
    required this.mode,
    this.error,
  });

  @override
  List<Object> get props => [items, status, mode];

  MinuteState copyWith({List<MinuteItem>? items, MinuteStatus? status, MinuteMode? mode, String? error}) {
    return MinuteState(
      items: items == null ? this.items : [...items],
      status: status ?? this.status,
      mode: mode ?? this.mode,
      error: error,
    );
  }
}

class MinuteInitial extends MinuteState {
  const MinuteInitial(List<MinuteItem> items) : super(items: items, mode: MinuteMode.draw, status: MinuteStatus.idle);
}
