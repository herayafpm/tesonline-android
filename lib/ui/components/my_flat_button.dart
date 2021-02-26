import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:tes_online/static_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFlatButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const MyFlatButton({this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      child: Txt("$title",
          style: TxtStyle()
            ..textColor(StaticData.textColor)
            ..fontSize(12.ssp)
            ..textAlign.right()),
      style: ParentStyle()..width(0.8.sw),
    );
  }
}
