import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/repositories/user/user_test_repository.dart';

part 'user_test_event.dart';
part 'user_test_state.dart';

class UserTestBloc extends Bloc<UserTestEvent, UserTestState> {
  UserTestBloc() : super(UserTestInitial());

  @override
  Stream<UserTestState> mapEventToState(
    UserTestEvent event,
  ) async* {
    if (event is UserTestGetEvent) {
      yield UserTestStateLoading();
      Map<String, dynamic> res = await UserTestRepository.getUserTest();
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield UserTestStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield UserTestStateError(res['data']);
      } else {
        yield UserTestStateError(res['data']);
      }
    } else if (event is UserTestPostEvent) {
      yield UserTestStateLoading();
      Map<String, dynamic> res =
          await UserTestRepository.postUserTest(event.json);
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield UserTestStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield UserTestStateError(res['data']);
      } else {
        yield UserTestStateError(res['data']);
      }
    }
  }
}
