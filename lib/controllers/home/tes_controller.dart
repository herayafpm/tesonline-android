import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/user/user_soal/user_soal_bloc.dart';
import 'package:tes_online/bloc/user/user_test/user_test_bloc.dart';
import 'package:tes_online/utils/toast_util.dart';

class TesController extends GetxController {
  final activeSoal = 0.obs;
  final soal = [].obs;
  final soal_ids = [].obs;
  final jawabans = [].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void backSoal(context) {
    if (activeSoal.value > 0) {
      activeSoal.value -= 1;
      BlocProvider.of<UserSoalBloc>(context)
        ..add(UserSoalGetEvent(int.parse(soal_ids[activeSoal.value])));
    }
  }

  void nextSoal(context) {
    print("data ${jawabans}");
    if (jawabans[activeSoal.value] == '') {
      ToastUtil.error(message: "Silahkan pilih satu jawaban");
      return;
    }
    if (activeSoal.value <= soal_ids.length) {
      activeSoal.value += 1;
      BlocProvider.of<UserSoalBloc>(context)
        ..add(UserSoalGetEvent(int.parse(soal_ids[activeSoal.value])));
    }
  }

  Widget itemCheckbox(String title, bool cek, String jawaban) {
    return new CheckboxListTile(
        activeColor: Colors.pink[300],
        dense: true,
        //font change
        title: new Text(
          title,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        value: cek ?? false,
        onChanged: (bool val) {
          if (val) {
            jawabans[activeSoal.value] = jawaban;
          }
        });
  }

  void proses(context) {
    isLoading.value = !isLoading.value;
    BlocProvider.of<UserTestBloc>(context)
      ..add(UserTestPostEvent({
        "soals": soal_ids,
        "jawabans": jawabans,
      }));
  }
}
