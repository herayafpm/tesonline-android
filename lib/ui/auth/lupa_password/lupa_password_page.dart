import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/lupa_password/lupa_password_bloc.dart';
import 'package:tes_online/controllers/auth/lupa_password_controller.dart';
import 'package:tes_online/ui/components/my_button.dart';
import 'package:tes_online/ui/components/my_flat_button.dart';
import 'package:tes_online/ui/components/my_input.dart';
import 'package:tes_online/ui/templates/auth_template.dart';
import 'package:tes_online/utils/toast_util.dart';

class LupaPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      title: "Lupa Password",
      body: BlocProvider(
        create: (context) => LupaPasswordBloc(),
        child: LupaPasswordView(),
      ),
    );
  }
}

class LupaPasswordView extends StatelessWidget {
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
            controller.email.value = state.data['data']['user_email'];
            Get.toNamed("/auth/lupa_password/cek_kode");
            ToastUtil.success(message: state.data['message'] ?? '');
          } else if (state is LupaPasswordStateError) {
            ToastUtil.error(
                message: state.errors['data']['user_username'] ??
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
              height: 0.04.sh,
            ),
            Obx(() => MyButton(
                  isLoading: controller.isLoading.value,
                  title: "Lanjut",
                  onTap: (controller.isLoading.value)
                      ? () {}
                      : () {
                          if (controller.key.currentState.validate()) {
                            controller.lupa(bloc);
                          }
                        },
                )),
            SizedBox(
              height: 0.02.sh,
            ),
            MyFlatButton(
                title: "Sudah ingat? masuk",
                onTap: () {
                  Get.offAllNamed("/auth/login");
                }),
          ],
        ),
      ),
    );
  }
}
