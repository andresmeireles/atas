import 'package:atas/src/core/utils/export.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

part 'minute_event.dart';
part 'minute_state.dart';
part 'minute_bloc_status.dart';

class MinuteBloc extends Bloc<MinuteEvent, MinuteState> {
  final User user;
  final MeetType meetType;
  final List<MeetItem> items;
  final MinuteSubmit minuteSubmit;

  MinuteBloc({
    required this.user,
    required this.meetType,
    required this.items,
    required this.minuteSubmit,
    List<MinuteItem> addedItems = const [],
  }) : super(
          MeetInitial.init(user: user, meet: meetType, items: items, addedItems: addedItems),
        ) {
    on<SubmitMinuteEvent>(_submitMinute);
    on<UpdateMinuteDateEvent>(_updateDate);
    on<AddMinuteItem>(_addMinuteItem);
    on<RemoveAddedItem>(_removeAddedItem);
    on<ClearErrorMessage>(_clearErrorMessage);
  }

  Future<void> _submitMinute(SubmitMinuteEvent event, Emitter emit) async {
    emit(state.copyWith(status: MinuteBlocStatus.submitting));
    final minute = Minutes(
      date: state.minute.date,
      schema: state.minute.schema,
      assignments: state.addedItems,
      user: event.user,
      status: state.minute.status,
    );
    final submit = await minuteSubmit.submit(minute);
    submit.when(
      (success) => emit(state.copyWith(status: MinuteBlocStatus.submitted)),
      (error) => emit(state.copyWith(status: MinuteBlocStatus.submitError, errorMessage: error.message)),
    );
  }

  _updateDate(UpdateMinuteDateEvent event, Emitter emit) {
    // final minute = state.minute.copyWith(date: event.date);
    // emit(state.copyWith(minute: minute));
  }

  _addMinuteItem(AddMinuteItem event, Emitter emit) {
    final type = event.type;
    final values = event.values;
    final label = event.label;

    MinuteItem minuteItem;

    switch (type) {
      case Types.call:
        minuteItem = CallItem(name: values.$1, call: values.$2, hash: generateRandomString(10), label: label);
        break;
      case Types.hymn:
        minuteItem = HymnItem(name: values.$1, number: values.$2, hash: generateRandomString(10), label: label);
        break;
      case Types.simpleText:
        minuteItem = SimpleTextItem(value: values, hash: generateRandomString(10), label: label);
        break;
    }
    emit(state.copyWith(addedItems: [...state.addedItems, minuteItem]));
  }

  _removeAddedItem(RemoveAddedItem event, Emitter emit) {
    final addedItems = List<MinuteItem>.from(state.addedItems);
    addedItems.removeWhere((i) => i.hash == event.item.hash);
    emit(state.copyWith(addedItems: addedItems));
  }

  _clearErrorMessage(ClearErrorMessage event, Emitter emit) {
    emit(state.copyWith(errorMessage: ''));
  }
}
