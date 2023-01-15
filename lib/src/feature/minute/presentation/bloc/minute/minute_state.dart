// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'minute_bloc.dart';

class MinuteState extends Equatable {
  final List<MinuteItem> items;
  final MinuteStatus status;
  final String? error;

  const MinuteState({
    required this.items,
    required this.status,
    this.error,
  });

  @override
  List<Object> get props => [items, status];

  MinuteState copyWith({List<MinuteItem>? items, MinuteStatus? status, String? error}) {
    return MinuteState(items: items == null ? this.items : [...items], status: status ?? this.status, error: error);
  }
}

class MinuteInitial extends MinuteState {
  const MinuteInitial(List<MinuteItem> items) : super(items: items, status: MinuteStatus.idle);
}
