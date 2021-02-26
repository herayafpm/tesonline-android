import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_online/static_data.dart';

class AuthTemplate extends StatelessWidget {
  final Widget body;
  final String title;
  final Function onBack;

  const AuthTemplate({this.body, this.title, this.onBack});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(20),
            children: [
              SizedBox(
                height: 0.1.sh,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    (onBack != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: onBack,
                              ),
                              Container(
                                child: Txt("$title",
                                    style: TxtStyle()
                                      ..textColor(StaticData.textColor)
                                      ..bold()
                                      ..fontSize(15.ssp)
                                      ..textAlign.center()
                                      ..textOverflow(TextOverflow.ellipsis)),
                              ),
                              Container(),
                              Container(),
                            ],
                          )
                        : Container(
                            child: Txt("$title",
                                style: TxtStyle()
                                  ..textColor(StaticData.textColor)
                                  ..bold()
                                  ..fontSize(15.ssp)
                                  ..textAlign.center()),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.04.sh,
              ),
              body
            ],
          ),
        ],
      ),
    );
  }
}
