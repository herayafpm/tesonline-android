import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_online/repositories/admin/tes_repository.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial());

  @override
  Stream<TestState> mapEventToState(
    TestEvent event,
  ) async* {
    if (event is TestGetListEvent) {
      int limit = 10;
      List<dynamic> tests = [];
      if (state is TestInitial || event.refresh) {
        Map<String, dynamic> res =
            await TesRepository.getListTes(limit: limit, offset: 0);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<dynamic>;
          tests = jsonObject;
          yield TestListLoaded(tests: tests, hasReachMax: false);
        } else if (res['statusCode'] == 400) {
          yield TestStateError(res['data']);
        } else {
          yield TestStateError(res['data']);
        }
      } else if (state is TestListLoaded) {
        TestListLoaded testListLoaded = state as TestListLoaded;
        Map<String, dynamic> res = await TesRepository.getListTes(
            limit: limit, offset: testListLoaded.tests.length);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<Map<String, dynamic>>;
          if (jsonObject.length == 0) {
            yield testListLoaded.copyWith(hasReachMax: true);
          } else {
            tests = jsonObject;
            yield TestListLoaded(
                tests: testListLoaded.tests + tests, hasReachMax: false);
          }
        } else if (res['statusCode'] == 400) {
          yield TestStateError(res['data']);
        } else {
          yield TestStateError(res['data']);
        }
      }
    }
  }
}
