import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tes_online/bloc/auth/login/login_bloc.dart';
import 'package:tes_online/controllers/auth/login_controller.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/ui/components/my_button.dart';
import 'package:tes_online/ui/components/my_flat_button.dart';
import 'package:tes_online/ui/components/my_input.dart';
import 'package:tes_online/ui/templates/auth_template.dart';
import 'package:tes_online/utils/toast_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
        title: "Login Aplikasi",
        body: BlocProvider(
          create: (context) => LoginBloc(),
          child: LoginView(),
        ));
  }
}

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());
  LoginBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginStateLoading) {
          controller.isLoading.value = true;
        } else {
          controller.isLoading.value = false;
          if (state is LoginStateSuccess) {
            var boxUser = await Hive.openBox("user_model");
            var userModel = UserModel.createFromJson(state.data['data']);
            try {
              boxUser.putAt(0, userModel);
            } catch (e) {
              boxUser.add(userModel);
            }
            controller.usernameController.text = "";
            controller.passwordController.text = "";
            Get.offAllNamed("/home");
          } else if (state is LoginStateError) {
            ToastUtil.error(message: state.errors['message'] ?? '');
          }
        }
      },
      child: Form(
        key: controller.key,
        child: Column(
          children: [
            MyInput(
              controller: controller.usernameController,
              title: "Username",
              validator: (value) {
                if (value.isEmpty) {
                  return "username tidak boleh kosong";
                }
                return null;
              },
            ),
            SizedBox(
              height: 0.03.sh,
            ),
            Obx(() => MyInput(
                  obsecure: !controller.showPass.value,
                  controller: controller.passwordController,
                  title: "Password",
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "password tidak boleh kosong";
                    }

                    return null;
                  },
                  icon: Parent(
                      gesture: Gestures()
                        ..onTap(() {
                          controller.showPass.value =
                              !controller.showPass.value;
                        }),
                      child: (!controller.showPass.value)
                          ? Icon(
                              Icons.visibility,
                            )
                          : Icon(
                              Icons.visibility_off,
                            )),
                )),
            SizedBox(
              height: 0.04.sh,
            ),
            Obx(() => MyButton(
                isLoading: controller.isLoading.value,
                title: "Login",
                onTap: (controller.isLoading.value)
                    ? () {}
                    : () {
                        if (controller.key.currentState.validate()) {
                          controller.login(bloc);
                        }
                      })),
            SizedBox(
              height: 0.02.sh,
            ),
            MyFlatButton(
                title: "Belum punya akun? daftar",
                onTap: () {
                  Get.offAllNamed("/auth/register");
                }),
            SizedBox(
              height: 0.01.sh,
            ),
            MyFlatButton(
                title: "Lupa Password?",
                onTap: () {
                  Get.offAllNamed("/auth/lupa_password");
                }),
          ],
        ),
      ),
    );
  }
}
