import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/login/login_bloc.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final showPass = false.obs;
  final isLoading = false.obs;

  void login(LoginBloc bloc) {
    isLoading.value = !isLoading.value;
    bloc..add(LoginBlocEvent(usernameController.text, passwordController.text));
  }
}
