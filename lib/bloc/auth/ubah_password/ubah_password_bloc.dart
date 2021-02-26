import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_online/repositories/auth/profile_repository.dart';

part 'ubah_password_event.dart';
part 'ubah_password_state.dart';

class UbahPasswordBloc extends Bloc<UbahPasswordEvent, UbahPasswordState> {
  UbahPasswordBloc() : super(UbahPasswordInitial());

  @override
  Stream<UbahPasswordState> mapEventToState(
    UbahPasswordEvent event,
  ) async* {
    if (event is UbahPasswordBlocEvent) {
      yield UbahPasswordStateLoading();
      Map<String, dynamic> res =
          await ProfileRepository.ubah_password(event.user_password);
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield UbahPasswordStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield UbahPasswordStateError(res['data']);
      } else {
        yield UbahPasswordStateError(res['data']);
      }
    }
  }
}
