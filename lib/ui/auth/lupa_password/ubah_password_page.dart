import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/lupa_password/lupa_password_bloc.dart';
import 'package:tes_online/controllers/auth/lupa_password_controller.dart';
import 'package:tes_online/ui/components/my_button.dart';
import 'package:tes_online/ui/components/my_input.dart';
import 'package:tes_online/ui/templates/auth_template.dart';
import 'package:tes_online/utils/toast_util.dart';

class UbahPasswordPage extends StatelessWidget {
  final controller = Get.put(LupaPasswordController());
  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      onBack: () {
        Get.offAllNamed("/auth/lupa_password");
      },
      title: "Ubah Password",
      body: BlocProvider(
        create: (context) => LupaPasswordBloc(),
        child: UbahPasswordView(),
      ),
    );
  }
}

class UbahPasswordView extends StatelessWidget {
  final controller = Get.put(LupaPasswordController());
  LupaPasswordBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<LupaPasswordBloc>(context);
    return BlocListener<LupaPasswordBloc, LupaPasswordState>(
      listener: (context, state) {
        if (state is LupaPasswordStateLoading) {
          controller.isLoading.value = true;
        } else {
          controller.isLoading.value = false;
          if (state is LupaPasswordStateSuccess) {
            Get.offAllNamed("/auth/login");
            controller.usernameController.text = "";
            controller.passwordController.text = "";
            controller.kodeOTPController.text = "";
            ToastUtil.success(message: state.data['message'] ?? '');
          } else if (state is LupaPasswordStateError) {
            ToastUtil.error(
                message: state.errors['data']['kode_otp'] ??
                    state.errors['message'] ??
                    '');
          }
        }
      },
      child: Form(
        key: controller.ubahPasswordkey,
        child: Column(
          children: [
            Obx(() => MyInput(
                  obsecure: !controller.showPass.value,
                  controller: controller.passwordController,
                  title: "Password Baru",
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "password baru tidak boleh kosong";
                    }
                    if (value.length < 6) {
                      return "password baru harus lebih dari 6 karakter";
                    }
                    return null;
                  },
                )),
            SizedBox(
              height: 0.04.sh,
            ),
            Obx(() => MyButton(
                  isLoading: controller.isLoading.value,
                  title: "Ubah",
                  onTap: (controller.isLoading.value)
                      ? () {}
                      : () {
                          if (controller.ubahPasswordkey.currentState
                              .validate()) {
                            controller.ubahPassword(bloc);
                          }
                        },
                )),
          ],
        ),
      ),
    );
  }
}
