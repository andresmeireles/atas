import 'package:atas/src/core/core.dart';
import 'package:atas/src/core/firebase/firbase.dart' as fb;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_status.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final userSp = User();
  final codeSp = Code();
  final codeFB = fb.Code();

  AppBloc() : super(const AppInitial()) {
    on<FetUserEvent>(_fetchUser);
    on<AddUserEvent>(_addUserName);
    on<FetchSecureCodeEvent>(_fetchSecureCode);
    on<AddCodeEvent>(_addCode);
    on<ClearUserEvent>(_clearUser);
  }

  _fetchUser(FetUserEvent event, Emitter emit) async {
    final user = await userSp.getUser();
    if (user == null || user.trim().isEmpty) {
      emit(state.copyWith(status: AppStatus.noUser));
      return;
    }
    emit(state.copyWith(user: user, status: AppStatus.ok));
  }

  Future<void> _addUserName(AddUserEvent event, Emitter emit) async {
    final user = event.user;
    if (user == null) {
      emit(state.copyWith(status: AppStatus.noUser));
      return;
    }
    await userSp.addUser(user);
    emit(state.copyWith(user: user, status: AppStatus.ok));
  }

  _fetchSecureCode(FetchSecureCodeEvent event, Emitter emit) async {
    final code = await codeSp.getCode();
    if (code == null) {
      emit(state.copyWith(status: AppStatus.noCode));
      return;
    }
    final securityCodeFromFirebase = await codeFB.securityCode;
    securityCodeFromFirebase.when(
      (success) {
        if (success == code) {
          emit(state.copyWith(code: success, status: AppStatus.ok));
          return;
        }
        emit(state.copyWith(status: AppStatus.noCode));
        return;
      },
      (error) {
        emit(state.copyWith(status: AppStatus.error));
        return;
      },
    );
  }

  _addCode(AddCodeEvent event, Emitter emit) async {
    final code = event.code;
    if (code == null) {
      emit(state.copyWith(status: AppStatus.wrongCode));
      return;
    }
    final firebaseCode = await codeFB.securityCode;
    if (firebaseCode.isError()) {
      emit(state.copyWith(status: AppStatus.wrongCode));
      return;
    }
    final c = firebaseCode.onSuccess((success) => success)!;
    if (c != code) {
      emit(state.copyWith(status: AppStatus.wrongCode));
      return;
    }
    final addedCode = await codeSp.addCode(c);
    emit(state.copyWith(code: addedCode, status: AppStatus.ok));
  }

  Future<void> _clearUser(ClearUserEvent event, Emitter emit) async {
    await userSp.removeUser();
    await codeSp.removeCode();
    emit(state.copyWith(user: '', code: 0, status: AppStatus.noCode));
  }
}
