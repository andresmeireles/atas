import 'package:atas/src/core/firebase/minute_list.dart' as firebase_minute_list;
import 'package:atas/src/core/firebase/minutes.dart' as firebase_minute;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../minute.dart';

part 'minute_event.dart';
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
    on<GetExistingMinuteEvent>(_getMinutes);
  }

  void _addMinuteItem(AddMinuteItemEvent event, Emitter emit) {
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
    final items = state.items;
    final schema = event.schema;
    final submitter = event.editedBy;
    final firebaseMinute = firebase_minute.Minutes();
    final firebaseMinuteList = firebase_minute_list.MinuteList();
    final validate = schema.validate(items);
    final status = validate.when(
      (success) async {
        final minuteName =
            await firebaseMinute.add(minuteItems: items, type: MinuteTypes.sacramental, editedBy: submitter);
        final minuteList = MinuteList(name: minuteName, status: MinuteListStatus.closed);
        await firebaseMinuteList.add(minuteList);
        return MinuteStatus.saved;
      },
      (error) => MinuteStatus.errorOnSave,
    ) as MinuteStatus;
    emit(state.copyWith(status: status));
  }

  void _removeItem(RemoveItemEvent event, Emitter emit) {
    final item = event.item;
    final currentItems = state.items;
    emit(state.copyWith(status: MinuteStatus.running));
    currentItems.removeWhere((element) => element.type == item.type && element.label == item.label);
    emit(state.copyWith(items: [...currentItems], status: MinuteStatus.idle));
  }

  void _getMinutes(GetExistingMinuteEvent event, Emitter emit) async {
    final api = firebase_minute.Minutes();
    emit(state.copyWith(status: MinuteStatus.fetching));
    final items = await api.byName(event.name);
    emit(state.copyWith(items: items, status: MinuteStatus.idle));
  }
}
