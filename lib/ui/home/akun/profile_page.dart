import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/auth/profile/profile_bloc.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/static_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_online/ui/components/error_state.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.toNamed("/akun/profile/ubah");
            },
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc()..add(ProfileGetEvent()),
        child: ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  ProfileBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ProfileStateSuccess) {
          UserModel user = UserModel.createFromJson(state.data['data']);
          return Column(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_box,
                      color: Colors.white,
                      size: 50.ssp,
                    ),
                    Txt(
                      "${user.user_nama.capitalize}",
                      style: TxtStyle()
                        ..fontSize(18.ssp)
                        ..textColor(Colors.white),
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 2,
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.mail),
                        tileColor: Colors.white,
                        title: Txt("Email"),
                        subtitle: Txt("${user.user_email}"),
                      ),
                    ],
                  )),
            ],
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
        return ErrorState(onTap: () {
          bloc..add(ProfileGetEvent());
        });
      },
    );
  }
}
