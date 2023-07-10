// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'minute_bloc.dart';

class MinuteState extends Equatable {
  final List<MeetItem> items;
  final List<MinuteItem> addedItems;
  final Minutes minute;
  final MinuteBlocStatus status;
  final String errorMessage;

  const MinuteState({
    required this.items,
    required this.addedItems,
    required this.minute,
    required this.status,
    this.errorMessage = '',
  });

  bool get isExpired => minute.status == MinuteStatus.expired;

  bool get isEditing => minute.id != null;

  @override
  List<Object> get props => [items, minute, status, errorMessage, addedItems];

  MinuteState copyWith({
    List<MeetItem>? items,
    Minutes? minute,
    bool? isExpired,
    MinuteBlocStatus? status,
    String? errorMessage,
    List<MinuteItem>? addedItems,
  }) {
    return MinuteState(
      items: items ?? this.items,
      minute: minute ?? this.minute,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      addedItems: addedItems ?? this.addedItems,
    );
  }

  Color get appBarBackgroundColor {
    switch (minute.status) {
      case MinuteStatus.draft:
        return Colors.yellow;
      case MinuteStatus.complete:
        return Colors.green;
      case MinuteStatus.expired:
        return Colors.brown.shade300;
      case MinuteStatus.hasObligatory:
        return Colors.blueAccent;
    }
  }

  Color get appBarForegroundColor {
    switch (minute.status) {
      case MinuteStatus.draft:
        return Colors.black;
      case MinuteStatus.complete:
        return Colors.white;
      case MinuteStatus.expired:
        return Colors.white;
      case MinuteStatus.hasObligatory:
        return Colors.white;
    }
  }
}

@immutable
class MeetInitial extends MinuteState {
  const MeetInitial._({required List<MeetItem> items, required Minutes minute, List<MinuteItem> addedItems = const []})
      : super(items: items, minute: minute, status: MinuteBlocStatus.editing, addedItems: addedItems);

  factory MeetInitial.init({
    required User user,
    required MeetType meet,
    required List<MeetItem> items,
    List<MinuteItem> addedItems = const [],
  }) {
    final schema = Schema.values.firstWhere((s) => s.value == meet.name);
    return MeetInitial._(items: items, minute: Minutes.init(user: user, schema: schema), addedItems: addedItems);
  }
}
