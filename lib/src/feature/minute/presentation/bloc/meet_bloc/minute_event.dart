// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'minute_bloc.dart';

abstract class MinuteEvent {
  const MinuteEvent();
}

class SubmitMinuteEvent implements MinuteEvent {
  final Minutes minute;
  final User user;

  SubmitMinuteEvent({required this.minute, required this.user});
}

class UpdateMinuteDateEvent implements MinuteEvent {
  final DateTime date;
  const UpdateMinuteDateEvent({required this.date});
}

class AddMinuteItem implements MinuteEvent {
  final Types type;
  final dynamic values;
  final String label;

  AddMinuteItem({required this.type, required this.label, required this.values});
}

class RemoveAddedItem implements MinuteEvent {
  final MinuteItem item;

  RemoveAddedItem(this.item);
}

class ClearErrorMessage implements MinuteEvent {}
