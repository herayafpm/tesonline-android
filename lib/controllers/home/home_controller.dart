import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/repositories/auth/profile_repository.dart';
import 'package:tes_online/repositories/user/user_test_repository.dart';
import 'package:tes_online/static_data.dart';
import 'package:tes_online/ui/home/akun_page.dart';
import 'package:tes_online/ui/home/dashboard_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeController extends GetxController {
  final activePage = 0.obs;
  final role = 0.obs;
  final userModel = UserModel().obs;
  final userTestScore = 0.obs;
  final keuntungan = 0.obs;
  List<Map<String, dynamic>> menus = [
    {
      "icon": Icon(Icons.home),
      "title": "Home",
    },
    {
      "icon": Icon(Icons.account_box_rounded),
      "title": "Akun",
    },
  ];
  List<Widget> listPage = [
    DashboardPage(),
    AkunPage(),
  ];
  List<Widget> listMenuDashboard = [];
  @override
  void onInit() async {
    try {
      var boxUser = await Hive.openBox("user_model");
      UserModel user = boxUser.getAt(0);
      if (user != null) {
        userModel.value = user;
      }
      role.value = user.role_id;
    } catch (e) {
      Get.offAllNamed("/auth/login");
    }
    super.onInit();
  }

  Widget tileDefault(
      {String title = "", Function onTap, Icon icon, Color color}) {
    return ListTile(
      title: Text("$title",
          style: TextStyle(
              fontSize: 14.ssp, color: color ?? StaticData.textColor)),
      tileColor: Colors.white,
      trailing: icon ?? Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void confirmLogout() {
    showDialog(
        context: Get.context,
        builder: (context) => AlertDialog(
              actions: [
                FlatButton(
                  child: Text("Tidak"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Ya"),
                  onPressed: () {
                    logout();
                  },
                )
              ],
              title: Text("Konfirmasi"),
              content: Text("Yakin ingin mengakhiri sesi?"),
            ));
  }

  void logout() async {
    Get.offAllNamed("/auth/login");
    await ProfileRepository.ubah_fcm("");
    try {
      var boxUser = await Hive.openBox("user_model");
      boxUser.deleteAt(0);
    } catch (e) {
      print("data $e");
    }
  }
}
