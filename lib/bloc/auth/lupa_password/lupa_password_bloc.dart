import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_online/repositories/auth/lupa_password_repository.dart';

part 'lupa_password_event.dart';
part 'lupa_password_state.dart';

class LupaPasswordBloc extends Bloc<LupaPasswordEvent, LupaPasswordState> {
  LupaPasswordBloc() : super(LupaPasswordInitial());

  @override
  Stream<LupaPasswordState> mapEventToState(
    LupaPasswordEvent event,
  ) async* {
    if (event is LupaPasswordBlocEvent) {
      yield LupaPasswordStateLoading();
      Map<String, dynamic> res =
          await LupaPasswordRepository.proses(event.user_username);
      if (res['statusCode'] == 400 || res['data']['status'] == false) {
        yield LupaPasswordStateError(res['data']);
      } else if (res['statusCode'] == 200) {
        yield LupaPasswordStateSuccess(res['data']);
      } else {
        yield LupaPasswordStateError(res['data']);
      }
    } else if (event is CekKodeEvent) {
      yield LupaPasswordStateLoading();
      Map<String, dynamic> res = await LupaPasswordRepository.cek_kode(
          event.user_email, event.kode_otp);
      if (res['statusCode'] == 400 || res['data']['status'] == false) {
        yield LupaPasswordStateError(res['data']);
      } else if (res['statusCode'] == 200) {
        yield LupaPasswordCekTokenSuccess(res['data']);
      } else {
        yield LupaPasswordStateError(res['data']);
      }
    } else if (event is UbahPasswordEvent) {
      yield LupaPasswordStateLoading();
      Map<String, dynamic> res = await LupaPasswordRepository.ubah_password(
          event.user_email, event.kode_otp, event.user_password);
      if (res['statusCode'] == 400 || res['data']['status'] == false) {
        yield LupaPasswordStateError(res['data']);
      } else if (res['statusCode'] == 200) {
        yield LupaPasswordStateSuccess(res['data']);
      } else {
        yield LupaPasswordStateError(res['data']);
      }
    }
  }
}
