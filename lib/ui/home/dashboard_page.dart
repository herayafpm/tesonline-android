import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/user/user_test/user_test_bloc.dart';
import 'package:tes_online/controllers/home/home_controller.dart';
import 'package:tes_online/static_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DashboardPage extends StatelessWidget {
  HomeController controller;
  @override
  Widget build(BuildContext context) {
    controller = Get.find<HomeController>();
    return Column(
      children: [
        Txt("Home",
            style: TxtStyle()
              ..fontSize(18..ssp)
              ..textColor(Colors.white)
              ..bold()),
        SizedBox(height: 20),
        Parent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Parent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt("Selamat datang,",
                        style: TxtStyle()
                          ..fontSize(14.ssp)
                          ..textColor(StaticData.textColor.withOpacity(0.8))),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => Txt(
                        "${controller.userModel.value.user_nama.capitalize}",
                        style: TxtStyle()
                          ..fontSize(18.ssp)
                          ..textColor(
                            StaticData.textColor,
                          ))),
                  ],
                ),
                style: ParentStyle()
                  ..padding(horizontal: 20, top: 20, bottom: 10),
              ),
              Obx(
                () => (controller.role.value == 1)
                    ? Expanded(
                        child: ListView(
                          children: [
                            controller.tileDefault(
                                title: "User Tes",
                                onTap: () {
                                  Get.toNamed("/admin/tes");
                                }),
                            SizedBox(
                              height: 0.01.sh,
                            ),
                            controller.tileDefault(
                                title: "Soal",
                                onTap: () {
                                  Get.toNamed("/admin/soal");
                                }),
                          ],
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Container(
                            child: BlocProvider(
                                create: (context) =>
                                    UserTestBloc()..add(UserTestGetEvent()),
                                child: BlocBuilder<UserTestBloc, UserTestState>(
                                    builder: (context, state) {
                                  if (state is UserTestStateSuccess) {
                                    if (state.data['data'] != null) {
                                      return Txt(
                                        "Score anda : ${state.data['data']['user_test_score']}",
                                        style: TxtStyle()..fontSize(16.ssp),
                                      );
                                    } else {
                                      return FlatButton(
                                        color: Colors.blueAccent,
                                        child: Text(
                                          "Mulai Tes",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Get.toNamed("/tes");
                                        },
                                      );
                                    }
                                  }
                                  return CircularProgressIndicator();
                                })))),
              ),
            ],
          ),
          style: ParentStyle()
            ..background.color(StaticData.bgColor2)
            ..width(Get.width)
            ..height(Get.height)
            ..borderRadius(all: 20),
        )
      ],
    );
  }
}
