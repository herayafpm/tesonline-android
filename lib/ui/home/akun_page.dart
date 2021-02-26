import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tes_online/controllers/home/home_controller.dart';
import 'package:tes_online/static_data.dart';

class AkunPage extends StatelessWidget {
  HomeController controller;
  @override
  Widget build(BuildContext context) {
    controller = Get.find<HomeController>();
    return Column(
      children: [
        Txt("Akun",
            style: TxtStyle()
              ..fontSize(18..ssp)
              ..textColor(Colors.white)
              ..bold()),
        SizedBox(height: 20),
        Parent(
          child: ListView(
            children: [
              tileDefault(
                  title: "Profile",
                  onTap: () {
                    Get.toNamed("/akun/profile");
                  }),
              SizedBox(
                height: 10,
              ),
              tileDefault(
                  title: "Ubah Password",
                  onTap: () {
                    Get.toNamed("/akun/profile/ubah_password");
                  }),
              SizedBox(
                height: 10,
              ),
              tileDefault(
                  title: "Logout",
                  onTap: () {
                    controller.confirmLogout();
                  },
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.redAccent,
                  ),
                  color: Colors.redAccent),
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

  Widget tileDefault({String title, Function onTap, Icon icon, Color color}) {
    return ListTile(
      title: Text("$title",
          style: TextStyle(
              fontSize: 14.ssp, color: color ?? StaticData.textColor)),
      tileColor: Colors.white,
      trailing: icon ?? Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
