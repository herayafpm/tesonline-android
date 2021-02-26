import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tes_online/controllers/home/home_controller.dart';
import 'package:tes_online/static_data.dart';

class HomePage extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      body: Stack(
        children: [
          Positioned(
            top: 0.1.sh,
            left: 0,
            right: 0,
            child: Obx(() => controller.listPage[controller.activePage.value]),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            left: 30,
            child: Parent(
                child: Obx(
                  () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: controller.menus
                          .asMap()
                          .map((key, value) => MapEntry(
                              key,
                              Flexible(
                                flex: 1,
                                child: FlatButton(
                                  textColor: StaticData.textColor.withOpacity(
                                      (controller.activePage.value == key)
                                          ? 1
                                          : 0.5),
                                  child: Column(
                                    children: [
                                      value['icon'],
                                      Txt("${value['title']}")
                                    ],
                                  ),
                                  onPressed: () {
                                    controller.activePage.value = key;
                                  },
                                ),
                              )))
                          .values
                          .toList()),
                ),
                style: ParentStyle()
                  ..height(55)
                  ..background.color(Colors.white)
                  ..elevation(2)
                  ..borderRadius(all: 10)
                  ..padding(vertical: 5)),
          )
        ],
      ),
    );
  }
}
