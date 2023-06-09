import 'dart:developer';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_status.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final Auth authApi;

  AppBloc(this.authApi) : super(const AppInitial()) {
    on<BootAppEvent>(_boot);
    on<AppLoginEvent>(_login);
    on<AppLogoutEvent>(_logout);
    on<ToBootedEvent>(_toBoot);
    on<CheckLoginEvent>(_check);
  }

  _boot(BootAppEvent event, Emitter emit) async {
    String? token = await getToken();
    // validate token
    // if invalid
    // setToken('');
    // token = '';
    emit(state.copyWith(token: token, status: AppStatus.booted));
  }

  _login(AppLoginEvent event, Emitter emit) async {
    final response = await authApi.login(event.username, event.password);
    if (response.isSuccess()) {
      final success = response.tryGetSuccess()!;
      await setToken(success.token);
      emit(state.copyWith(token: success.token, status: AppStatus.booted));
    }
    if (response.isError()) {
      emit(state.copyWith(token: '', status: AppStatus.failLogin));
    }
  }

  _logout(AppLogoutEvent event, Emitter emit) async {
    await setToken('');
    emit(state.copyWith(token: '', status: AppStatus.loggedOut));
  }

  _toBoot(ToBootedEvent event, Emitter emit) {
    emit(state.copyWith(status: AppStatus.booted));
  }

  _check(CheckLoginEvent event, Emitter emit) async {
    try {
      final user = await authApi.check();
      if (user.isError()) {
        emit(state.copyWith(token: '', status: AppStatus.loggedOut));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(token: '', status: AppStatus.loggedOut));
    }
  }
}
