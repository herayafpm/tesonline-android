import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/register/register_bloc.dart';
import 'package:tes_online/models/user_model.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final user = UserModel().obs;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final showPass = false.obs;
  final isLoading = false.obs;

  void register(RegisterBloc bloc) {
    isLoading.value = !isLoading.value;
    user.update((val) {
      val.user_nama = namaController.text;
      val.user_username = usernameController.text;
      val.user_email = emailController.text;
      val.user_password = passwordController.text;
    });
    bloc..add(RegisterBlocEvent(user.value));
  }
}
