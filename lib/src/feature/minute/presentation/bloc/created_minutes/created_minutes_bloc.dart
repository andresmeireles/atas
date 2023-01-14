import 'package:atas/src/core/firebase/minute_list.dart' as firebase_minute_list;
import 'package:atas/src/feature/minute/minute.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'created_minutes_event.dart';
part 'created_minutes_state.dart';

class CreatedMinutesBloc extends Bloc<CreatedMinutesEvent, CreatedMinutesState> {
  final _api = firebase_minute_list.MinuteList();

  CreatedMinutesBloc() : super(CreatedMinutesInitial()) {
    on<FetchMinutesEvent>(_fetchCreatedMinutes);
  }

  _fetchCreatedMinutes(FetchMinutesEvent event, Emitter emit) async {
    emit(state.copyWith(status: CreatedMinuteStatus.fetching));
    final minutes = await _api.minutes;
    minutes.when(
      (success) => emit(state.copyWith(minutes: success, status: CreatedMinuteStatus.loaded)),
      (error) => emit(state.copyWith(status: CreatedMinuteStatus.error)),
    );
  }
}
