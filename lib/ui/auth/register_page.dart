import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tes_online/bloc/auth/login/login_bloc.dart';
import 'package:tes_online/bloc/auth/register/register_bloc.dart';
import 'package:tes_online/controllers/auth/login_controller.dart';
import 'package:tes_online/controllers/auth/register_controller.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/ui/components/my_button.dart';
import 'package:tes_online/ui/components/my_flat_button.dart';
import 'package:tes_online/ui/components/my_input.dart';
import 'package:tes_online/ui/templates/auth_template.dart';
import 'package:tes_online/utils/toast_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
        title: "Daftar Aplikasi",
        body: BlocProvider(
          create: (context) => RegisterBloc(),
          child: RegisterView(),
        ));
  }
}

class RegisterView extends StatelessWidget {
  final controller = Get.put(RegisterController());
  RegisterBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<RegisterBloc>(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterStateLoading) {
          controller.isLoading.value = true;
        } else {
          controller.isLoading.value = false;
          if (state is RegisterStateSuccess) {
            ToastUtil.success(message: state.data['message'] ?? '');
            Get.offAllNamed("/auth/login");
          } else if (state is RegisterStateError) {
            ToastUtil.error(
                message: state.errors['data']['user_username'] ??
                    state.errors['data']['user_email'] ??
                    state.errors['message'] ??
                    '');
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
            MyInput(
              controller: controller.namaController,
              title: "Nama",
              validator: (value) {
                if (value.isEmpty) {
                  return "nama lengkap tidak boleh kosong";
                }
                return null;
              },
            ),
            SizedBox(
              height: 0.03.sh,
            ),
            MyInput(
              controller: controller.emailController,
              title: "Email",
              validator: (String value) {
                if (value.isEmpty) {
                  return "email tidak boleh kosong";
                }
                if (!value.isEmail) {
                  return "email tidak valid";
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
                    if (value.length < 5) {
                      return "password harus lebih dari 6 karakter";
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
                title: "Daftar",
                onTap: (controller.isLoading.value)
                    ? () {}
                    : () {
                        if (controller.key.currentState.validate()) {
                          controller.register(bloc);
                        }
                      })),
            SizedBox(
              height: 0.02.sh,
            ),
            MyFlatButton(
                title: "Sudah punya akun? login",
                onTap: () {
                  Get.offAllNamed("/auth/login");
                }),
          ],
        ),
      ),
    );
  }
}
