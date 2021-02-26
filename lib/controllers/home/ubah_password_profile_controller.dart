import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/ubah_password/ubah_password_bloc.dart';

class UbahPasswordProfileController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final isLoading = false.obs;
  final showPass = false.obs;

  void ubah(UbahPasswordBloc bloc) {
    isLoading.value = !isLoading.value;
    bloc..add(UbahPasswordBlocEvent(passwordController.text));
  }
}
