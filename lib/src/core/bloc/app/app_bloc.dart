import 'package:atas/src/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final userSp = User();

  AppBloc() : super(const AppInitial()) {
    on<AddUserName>(_addUserName);
    on<ClearUserEvent>(_clearUser);
  }

  Future<void> _addUserName(AddUserName event, Emitter emit) async {
    final user = await userSp.getUser();
    if (user == null || user.trim().isEmpty) {
      emit(state.copyWith(redirect: true));
      return;
    }
    emit(state.copyWith(user: user, redirect: false));
  }

  Future<void> _clearUser(ClearUserEvent event, Emitter emit) async {
    await userSp.removeUser();
    emit(state.copyWith(user: '', redirect: true));
  }
}
