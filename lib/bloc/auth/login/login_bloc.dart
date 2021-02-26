import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_online/repositories/auth/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginBlocEvent) {
      yield LoginStateLoading();
      Map<String, dynamic> res = await LoginRepository.proses(
          event.user_username, event.user_password);
      if (res['statusCode'] == 400 || res['data']['status'] == false) {
        yield LoginStateError(res['data']);
      } else if (res['statusCode'] == 200) {
        yield LoginStateSuccess(res['data']);
      } else {
        yield LoginStateError(res['data']);
      }
    }
  }
}
