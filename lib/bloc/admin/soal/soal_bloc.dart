import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_online/repositories/admin/soal_repository.dart';

part 'soal_event.dart';
part 'soal_state.dart';

class SoalBloc extends Bloc<SoalEvent, SoalState> {
  SoalBloc() : super(SoalInitial());

  @override
  Stream<SoalState> mapEventToState(
    SoalEvent event,
  ) async* {
    if (event is SoalGetListEvent) {
      int limit = 10;
      List<dynamic> soals = [];
      if (state is SoalInitial || event.refresh) {
        Map<String, dynamic> res =
            await SoalRepository.getListSoal(limit: limit, offset: 0);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<dynamic>;
          soals = jsonObject;
          yield SoalListLoaded(soals: soals, hasReachMax: false);
        } else if (res['statusCode'] == 400) {
          yield SoalStateError(res['data']);
        } else {
          yield SoalStateError(res['data']);
        }
      } else if (state is SoalListLoaded) {
        SoalListLoaded soalListLoaded = state as SoalListLoaded;
        Map<String, dynamic> res = await SoalRepository.getListSoal(
            limit: limit, offset: soalListLoaded.soals.length);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<Map<String, dynamic>>;
          if (jsonObject.length == 0) {
            yield soalListLoaded.copyWith(hasReachMax: true);
          } else {
            soals = jsonObject;
            yield SoalListLoaded(
                soals: soalListLoaded.soals + soals, hasReachMax: false);
          }
        } else if (res['statusCode'] == 400) {
          yield SoalStateError(res['data']);
        } else {
          yield SoalStateError(res['data']);
        }
      }
    } else if (event is SoalTambahEvent) {
      Map<String, dynamic> res = await SoalRepository.postSoal(event.json);
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield SoalStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield SoalStateError(res['data']);
      } else {
        yield SoalStateError(res['data']);
      }
    } else if (event is SoalEditEvent) {
      Map<String, dynamic> res =
          await SoalRepository.putSoal(event.json['soal_id'], event.json);
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield SoalFormSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield SoalStateError(res['data']);
      } else {
        yield SoalStateError(res['data']);
      }
    } else if (event is SoalDeleteEvent) {
      Map<String, dynamic> res = await SoalRepository.deleteSoal(event.id);
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield SoalStateSuccess(res['data']);
        this..add(SoalGetListEvent(refresh: true));
      } else if (res['statusCode'] == 400) {
        yield SoalStateError(res['data']);
        this..add(SoalGetListEvent(refresh: true));
      } else {
        yield SoalStateError(res['data']);
        this..add(SoalGetListEvent(refresh: true));
      }
    } else if (event is SoalGetEvent) {
      Map<String, dynamic> res = await SoalRepository.getSoal(event.id);
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield SoalStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield SoalStateError(res['data']);
      } else {
        yield SoalStateError(res['data']);
      }
    } else if (event is SoalSetStatusEvent) {
      Map<String, dynamic> res =
          await SoalRepository.setStatus(event.id, event.status);
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield SoalStateSuccess(res['data']);
        this..add(SoalGetListEvent(refresh: true));
      } else if (res['statusCode'] == 400) {
        yield SoalStateError(res['data']);
        this..add(SoalGetListEvent(refresh: true));
      } else {
        yield SoalStateError(res['data']);
        this..add(SoalGetListEvent(refresh: true));
      }
    }
  }
}
