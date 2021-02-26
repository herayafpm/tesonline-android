import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/profile/profile_bloc.dart';
import 'package:tes_online/controllers/home/profile_controller.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/static_data.dart';
import 'package:tes_online/ui/components/my_button.dart';
import 'package:tes_online/ui/components/my_input.dart';
import 'package:tes_online/utils/toast_util.dart';

class UbahProfilePage extends StatelessWidget {
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      appBar: AppBar(
        title: Text("Ubah Profile"),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc()..add(ProfileGetEvent()),
        child: ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final controller = Get.find<ProfileController>();
  ProfileBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileStateLoading) {
            // controller.isLoading.value = true;
          } else {
            controller.isLoading.value = false;
            if (state is ProfileFormStateSuccess) {
              controller.namaController.text = "";
              controller.emailController.text = "";
              Get.offNamedUntil("/akun/profile", ModalRoute.withName('/home'));
              ToastUtil.success(message: state.data['message'] ?? '');
            } else if (state is ProfileStateError) {
              ToastUtil.error(
                  message: state.errors['data']['user_email'] ??
                      state.errors['message'] ??
                      '');
            }
          }
        },
        builder: (context, state) {
          if (state is ProfileStateSuccess) {
            UserModel user = UserModel.createFromJson(state.data['data']);
            controller.namaController.text = user.user_nama;
            controller.emailController.text = user.user_email;
            controller.user.value = user;
            return Form(
              key: controller.key,
              child: ListView(
                children: [
                  MyInput(
                    title: "Nama",
                    controller: controller.namaController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "username tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyInput(
                    type: TextInputType.emailAddress,
                    title: "Email",
                    controller: controller.emailController,
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
            );
          } else if (state is ProfileStateLoading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            );
          }
          return Align(
            alignment: Alignment.center,
            child: errorState(),
          );
        },
      ),
    );
  }

  Widget errorState() {
    return Parent(
      style: ParentStyle()..ripple(true, splashColor: Colors.blueAccent),
      gesture: Gestures()
        ..onTap(() {
          bloc..add(ProfileGetEvent());
        }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.refresh),
          Text(
            "Ada gangguan, silahkan refresh",
          ),
        ],
      ),
    );
  }
}
