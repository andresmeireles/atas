import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_status.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final Auth authApi;

  AppBloc(this.authApi) : super(AppInitial()) {
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
    try {
      if (response.isSuccess()) {
        final success = response.tryGetSuccess()!;
        final token = success.token.substring(success.token.indexOf('|') + 1, success.token.length);
        await setToken(token);
        final user = await authApi.check();
        if (user.isSuccess()) {
          emit(state.copyWith(user: user.tryGetSuccess(), token: token, status: AppStatus.booted));
          return;
        }
      }
      throw response.tryGetError()!.message;
    } catch (e) {
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
      emit(state.copyWith(token: '', status: AppStatus.loggedOut));
    }
  }
}
