// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'minute_bloc.dart';

abstract class MinuteEvent extends Equatable {
  const MinuteEvent();

  @override
  List<Object?> get props => [];
}

class AddMinuteItemEvent extends MinuteEvent {
  final MinuteItem item;

  const AddMinuteItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveItemEvent extends MinuteEvent {
  final MinuteItem item;

  const RemoveItemEvent(this.item);
}

class GetExistingMinuteEvent extends MinuteEvent {
  final String id;

  const GetExistingMinuteEvent({
    required this.id,
  });
}

class AddMinuteOnFirebaseEvent extends MinuteEvent {
  final String editedBy;
  final SchemaInterface schema;
  final bool isUpdate;

  const AddMinuteOnFirebaseEvent({required this.editedBy, required this.schema, this.isUpdate = false});
}
