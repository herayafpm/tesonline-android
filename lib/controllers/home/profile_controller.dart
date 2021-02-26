import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/profile/profile_bloc.dart';
import 'package:tes_online/models/user_model.dart';

class ProfileController extends GetxController {
  final user = UserModel().obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final isLoading = false.obs;

  void ubah(ProfileBloc bloc) {
    isLoading.value = !isLoading.value;
    user.update((value) {
      value.user_nama = namaController.text;
      value.user_email = emailController.text;
    });
    bloc..add(ProfileUbahEvent(user.value));
  }
}
