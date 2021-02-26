import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/admin/soal/soal_bloc.dart';

class FormSoalController extends GetxController {
  TextEditingController soalIsiController = TextEditingController();
  TextEditingController jawabanAController = TextEditingController();
  TextEditingController jawabanBController = TextEditingController();
  TextEditingController jawabanCController = TextEditingController();
  TextEditingController jawabanDController = TextEditingController();
  TextEditingController kunciJawabanController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final isLoading = false.obs;
  int soal_id = 0;

  void updateData(json) {
    soal_id = int.parse(json['soal_id']);
    soalIsiController.text = json['soal_isi'];
    jawabanAController.text = json['jawaban_a'];
    jawabanBController.text = json['jawaban_b'];
    jawabanCController.text = json['jawaban_c'];
    jawabanDController.text = json['jawaban_d'];
    kunciJawabanController.text = json['kunci_jawaban'];
  }

  void tambah(context) {
    isLoading.value = !isLoading.value;
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['soal_isi'] = soalIsiController.text;
    json['jawaban_a'] = jawabanAController.text;
    json['jawaban_b'] = jawabanBController.text;
    json['jawaban_c'] = jawabanCController.text;
    json['jawaban_d'] = jawabanDController.text;
    json['kunci_jawaban'] = kunciJawabanController.text;
    BlocProvider.of<SoalBloc>(context)..add(SoalTambahEvent(json));
  }

  void ubah(context) {
    isLoading.value = !isLoading.value;
    print("data $soal_id");
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['soal_id'] = soal_id;
    json['soal_isi'] = soalIsiController.text;
    json['jawaban_a'] = jawabanAController.text;
    json['jawaban_b'] = jawabanBController.text;
    json['jawaban_c'] = jawabanCController.text;
    json['jawaban_d'] = jawabanDController.text;
    json['kunci_jawaban'] = kunciJawabanController.text;
    BlocProvider.of<SoalBloc>(context)..add(SoalEditEvent(json));
  }
}
