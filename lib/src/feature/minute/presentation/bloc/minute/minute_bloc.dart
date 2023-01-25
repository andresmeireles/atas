import 'dart:developer';

import 'package:atas/src/core/exception/minute_exists_exception.dart';
import 'package:atas/src/core/exception/minute_not_exists_exeception.dart';
import 'package:atas/src/core/firebase/minute_list.dart' as firebase_minute_list;
import 'package:atas/src/core/firebase/minutes.dart' as firebase_minute;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../minute.dart';

part 'minute_event.dart';
part 'minute_mode.dart';
part 'minute_state.dart';
part 'minute_status.dart';

class MinuteBloc extends Bloc<MinuteEvent, MinuteState> {
  final repeatableLabels = [
    MinuteLabel.acknowledgment,
    MinuteLabel.announcement,
    MinuteLabel.call,
    MinuteLabel.callRelease,
    MinuteLabel.confirmation,
    MinuteLabel.namingChild,
  ];

  MinuteBloc(List<MinuteItem> item) : super(MinuteInitial(item)) {
    on<AddMinuteItemEvent>(_addMinuteItem);
    on<AddMinuteOnFirebaseEvent>(_addMinuteOnFirebase);
    on<RemoveItemEvent>(_removeItem);
    on<GetExistingMinuteEvent>(_getMinute);
  }

  _addMinuteItem(AddMinuteItemEvent event, Emitter emit) {
    final item = event.item;
    final currentItems = state.items;
    final isRepeatable = repeatableLabels.contains(item.label);
    final hasItem = currentItems.indexWhere((element) => element.label == item.label) != -1;
    if (!isRepeatable && hasItem) {
      emit(state.copyWith(status: MinuteStatus.loadInvalidItem));
      return;
    }
    final newItems = [...currentItems, item];
    emit(state.copyWith(items: newItems, status: MinuteStatus.idle));
  }

  _addMinuteOnFirebase(AddMinuteOnFirebaseEvent event, Emitter emit) async {
    emit(state.copyWith(status: MinuteStatus.saving));
    final isUpdate = event.isUpdate;
    final items = state.items;
    final schema = event.schema;
    final submitter = event.editedBy;
    final firebaseMinute = firebase_minute.Minutes();
    final firebaseMinuteList = firebase_minute_list.MinuteList();
    final validate = schema.validate(items);
    final mode = validate ? MinuteMode.ready : MinuteMode.draw;
    try {
      final createdAt = items.firstWhere((element) => element.label == MinuteLabel.meetingDate) as SimpleText;
      final meetingDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(createdAt.value));
      final minuteName = '${MinuteTypes.sacramental.toString()}-$meetingDate';
      final minuteList = MinuteList(name: minuteName, status: mode);
      final minuteExists = await firebaseMinuteList.minuteExists(minuteName);
      if (!isUpdate && minuteExists) {
        throw MinuteExistsException(minuteName);
      }
      if (isUpdate && !minuteExists) {
        throw MinuteNotExistsException(minuteName);
      }
      if (isUpdate) {
        final itemId = await firebaseMinuteList.minuteListByName(minuteName);
        await firebaseMinuteList.update(itemId, minuteList);
        await firebaseMinute.update(
          minuteName: minuteName,
          minuteItems: items,
          type: MinuteTypes.sacramental,
          editedBy: submitter,
        );
        emit(state.copyWith(status: MinuteStatus.updated));
      }
      if (!isUpdate) {
        await firebaseMinuteList.add(minuteList);
        await firebaseMinute.add(
          minuteName: minuteName,
          minuteItems: items,
          type: MinuteTypes.sacramental,
          editedBy: submitter,
        );
        emit(state.copyWith(status: MinuteStatus.saved));
      }
    } on MinuteExistsException catch (e) {
      log(e.toString());
      emit(state.copyWith(status: MinuteStatus.errorOnSave, error: e.toString()));
    } on MinuteNotExistsException catch (e) {
      log(e.toString());
      emit(state.copyWith(status: MinuteStatus.errorOnSave, error: e.toString()));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: MinuteStatus.errorOnSave));
    }
  }

  _removeItem(RemoveItemEvent event, Emitter emit) {
    final item = event.item;
    final currentItems = state.items;
    emit(state.copyWith(status: MinuteStatus.running));
    currentItems.removeWhere((element) => element.type == item.type && element.label == item.label);
    emit(state.copyWith(items: [...currentItems], status: MinuteStatus.idle));
  }

  _getMinute(GetExistingMinuteEvent event, Emitter emit) async {
    final minutesList = firebase_minute_list.MinuteList();
    final api = firebase_minute.Minutes();
    emit(state.copyWith(status: MinuteStatus.fetching));
    final itemFromList = await minutesList.minuteById(event.id);
    if (itemFromList.isError()) {
      final errorMessage = itemFromList.onError((error) => error);
      emit(state.copyWith(error: errorMessage, status: MinuteStatus.errorOnFetching));
      return;
    }
    final minuteItem = itemFromList.onSuccess((success) => success)!;
    final items = await api.byName(minuteItem.name);
    // emit(state.copyWith(items: items, status: MinuteStatus.idle, mode: minuteItem.status));
    emit(state.copyWith(items: items, status: MinuteStatus.idle, mode: MinuteMode.updating));
  }
}
