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

class CekKodePage extends StatelessWidget {
  final controller = Get.put(LupaPasswordController());
  @override
  Widget build(BuildContext context) {
    controller.kirimUlangTimer.value = 60;
    controller.setTimerPeriodic();
    return AuthTemplate(
      title: "Masukkan OTP (One Time Password)",
      onBack: () {
        Get.offAllNamed("/auth/lupa_password");
      },
      body: BlocProvider(
        create: (context) => LupaPasswordBloc(),
        child: CekKodeView(),
      ),
    );
  }
}

class CekKodeView extends StatelessWidget {
  final controller = Get.find<LupaPasswordController>();
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
          if (state is LupaPasswordCekTokenSuccess) {
            Get.toNamed("/auth/lupa_password/ubah_password");
          } else if (state is LupaPasswordStateSuccess) {
            controller.kirimUlangTimer.value = 60;
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
        key: controller.cekKodeOTPkey,
        child: Column(
          children: [
            MyInput(
              type: TextInputType.number,
              controller: controller.kodeOTPController,
              title: "Kode OTP",
              validator: (String value) {
                if (value.isEmpty) {
                  return "kode tidak boleh kosong";
                }
                if (value.length != 6) {
                  return "kode harus sama dengan 6 karakter";
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
                          if (controller.cekKodeOTPkey.currentState
                              .validate()) {
                            controller.cekKode(bloc);
                          }
                        },
                )),
            SizedBox(
              height: 0.02.sh,
            ),
            Obx(() => MyFlatButton(
                title: (controller.kirimUlangTimer.value > 0)
                    ? "Belum menerima email? tunggu ${controller.kirimUlangTimer.value} detik untuk mengirim ulang"
                    : "Belum menerima email? Kirim ulang",
                onTap: () {
                  if (controller.kirimUlangTimer.value <= 0) {
                    controller.lupa(bloc);
                  }
                })),
          ],
        ),
      ),
    );
  }
}
