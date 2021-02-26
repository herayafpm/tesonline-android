import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_online/controllers/splash_screen_controller.dart';
import 'package:tes_online/static_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreenPage extends StatelessWidget {
  final controller = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Parent(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(
                        "Tes Online 129",
                        style: TxtStyle()
                          ..textColor(StaticData.textColor)
                          ..fontSize(14.ssp)
                          ..fontWeight(FontWeight.bold),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Txt(
                        "Versi 1.0",
                        style: TxtStyle()
                          ..fontSize(14.ssp)
                          ..textColor(StaticData.textColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
            style: ParentStyle()
              ..width(1.sw)
              ..height(1.sh)
              ..padding(vertical: 0.05.sh, horizontal: 0.05.sw)));
  }
}
