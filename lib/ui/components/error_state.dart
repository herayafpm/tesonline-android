import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorState extends StatelessWidget {
  final Function onTap;
  final String title;

  const ErrorState({this.onTap, this.title = "Ada gangguan, silahkan refresh"});
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..ripple(true, splashColor: Colors.blueAccent)
        ..width(Get.width),
      gesture: Gestures()..onTap(onTap()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.refresh),
          Text(
            "$title",
          ),
        ],
      ),
    );
  }
}
