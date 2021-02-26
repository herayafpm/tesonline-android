import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyState extends StatelessWidget {
  final String title;

  const EmptyState({this.title = "data kosong"});
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..ripple(true, splashColor: Colors.blueAccent)
        ..width(Get.width)
        ..alignment.center()
        ..alignmentContent.center(),
      child: Text(
        "$title",
      ),
    );
  }
}
