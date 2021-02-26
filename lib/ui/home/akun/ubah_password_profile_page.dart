import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/ubah_password/ubah_password_bloc.dart';
import 'package:tes_online/controllers/home/ubah_password_profile_controller.dart';
import 'package:tes_online/static_data.dart';
import 'package:tes_online/ui/components/my_button.dart';
import 'package:tes_online/ui/components/my_input.dart';
import 'package:tes_online/utils/toast_util.dart';

class UbahPasswordProfilePage extends StatelessWidget {
  final controller = Get.put(UbahPasswordProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      appBar: AppBar(
        title: Text("Ubah Password"),
      ),
      body: BlocProvider(
        create: (context) => UbahPasswordBloc(),
        child: UbahPasswordProfileView(),
      ),
    );
  }
}

class UbahPasswordProfileView extends StatelessWidget {
  final controller = Get.find<UbahPasswordProfileController>();
  UbahPasswordBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<UbahPasswordBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: BlocListener<UbahPasswordBloc, UbahPasswordState>(
        listener: (context, state) {
          if (state is UbahPasswordStateLoading) {
            controller.isLoading.value = true;
          } else {
            controller.isLoading.value = false;
            if (state is UbahPasswordStateSuccess) {
              Get.offNamedUntil("/akun/profile", ModalRoute.withName('/home'));
              ToastUtil.success(message: state.data['message'] ?? '');
            } else if (state is UbahPasswordStateError) {
              ToastUtil.error(message: state.errors['message'] ?? '');
            }
          }
        },
        child: Form(
          key: controller.key,
          child: ListView(
            children: [
              Obx(() => MyInput(
                    obsecure: !controller.showPass.value,
                    controller: controller.passwordController,
                    title: "Password Baru",
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "password tidak boleh kosong";
                      }
                      if (value.length < 6) {
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
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(() => MyButton(
                      isLoading: controller.isLoading.value,
                      title: "Simpan",
                      onTap: (controller.isLoading.value)
                          ? () {}
                          : () {
                              FormState state = controller.key.currentState;
                              if (state != null) if (state.validate()) {
                                controller.ubah(bloc);
                              }
                            },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
