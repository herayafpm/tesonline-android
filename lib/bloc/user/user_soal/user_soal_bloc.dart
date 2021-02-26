import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/repositories/user/user_soal_repository.dart';

part 'user_soal_event.dart';
part 'user_soal_state.dart';

class UserSoalBloc extends Bloc<UserSoalEvent, UserSoalState> {
  UserSoalBloc() : super(UserSoalInitial());

  @override
  Stream<UserSoalState> mapEventToState(
    UserSoalEvent event,
  ) async* {
    if (event is UserSoalsGetEvent) {
      yield UserSoalStateLoading();
      Map<String, dynamic> res = await UserSoalRepository.getSoals();
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield UserSoalsStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield UserSoalStateError(res['data']);
      } else {
        yield UserSoalStateError(res['data']);
      }
    } else if (event is UserSoalGetEvent) {
      yield UserSoalStateLoading();
      Map<String, dynamic> res = await UserSoalRepository.getSoal(event.id);
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield UserSoalStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield UserSoalStateError(res['data']);
      } else {
        yield UserSoalStateError(res['data']);
      }
    }
  }
}
