import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/repositories/auth/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileGetEvent) {
      yield ProfileStateLoading();
      Map<String, dynamic> res = await ProfileRepository.getProfile();
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield ProfileStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        yield ProfileStateError(res['data']);
      } else {
        yield ProfileStateError(res['data']);
      }
    } else if (event is ProfileUbahEvent) {
      yield ProfileStateLoading();
      Map<String, dynamic> res =
          await ProfileRepository.ubah_profile(event.user.toJson());
      if (res['statusCode'] == 200 && res['data']['status'] == 1) {
        yield ProfileFormStateSuccess(res['data']);
      } else if (res['statusCode'] == 400) {
        this..add(ProfileGetEvent());
        yield ProfileStateError(res['data']);
      } else {
        this..add(ProfileGetEvent());
        yield ProfileStateError(res['data']);
      }
    }
  }
}
