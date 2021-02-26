import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/admin/soal/soal_bloc.dart';
import 'package:tes_online/controllers/home/form_soal_controller.dart';
import 'package:tes_online/static_data.dart';
import 'package:tes_online/ui/components/my_button.dart';
import 'package:tes_online/ui/components/my_input.dart';
import 'package:tes_online/ui/components/my_input_button.dart';
import 'package:tes_online/utils/toast_util.dart';

class UbahSoalPage extends StatelessWidget {
  final controller = Get.put(FormSoalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      appBar: AppBar(
        title: Text("Ubah Soal"),
      ),
      body: BlocProvider(
        create: (context) =>
            SoalBloc()..add(SoalGetEvent(int.parse(Get.arguments['id']))),
        child: UbahSoalView(),
      ),
    );
  }
}

class UbahSoalView extends StatelessWidget {
  final controller = Get.find<FormSoalController>();
  SoalBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SoalBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: BlocListener<SoalBloc, SoalState>(
        listener: (context, state) {
          if (state is SoalStateError) {
            controller.isLoading.value = false;
            ToastUtil.error(message: state.errors['message'] ?? '');
          } else if (state is SoalFormSuccess) {
            controller.isLoading.value = false;
            Get.offNamedUntil("/admin/soal", ModalRoute.withName('/home'));
            ToastUtil.success(message: state.data['message'] ?? '');
          } else if (state is SoalStateSuccess) {
            controller.updateData(state.data['data']);
          }
        },
        child: Form(
          key: controller.key,
          child: ListView(
            children: [
              MyInput(
                title: "Soal Isi",
                controller: controller.soalIsiController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Soal tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              MyInput(
                title: "Jawaban A",
                controller: controller.jawabanAController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Jawaban A tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              MyInput(
                title: "Jawaban B",
                controller: controller.jawabanBController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Jawaban B tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              MyInput(
                title: "Jawaban C",
                controller: controller.jawabanCController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Jawaban C tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              MyInput(
                title: "Jawaban D",
                controller: controller.jawabanDController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Jawaban D tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              MyInputButton(
                title: "Kunci Jawaban",
                controller: controller.kunciJawabanController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "kunci jawaban tidak boleh kosong";
                  }
                  return null;
                },
                datas: [
                  {
                    "id": "",
                    "nama": "--Pilih Jawaban--",
                  },
                  {
                    "id": "a",
                    "nama": "A",
                  },
                  {
                    "id": "b",
                    "nama": "B",
                  },
                  {
                    "id": "c",
                    "nama": "C",
                  },
                  {
                    "id": "d",
                    "nama": "D",
                  },
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(() => MyButton(
                    isLoading: controller.isLoading.value,
                    title: "Simpan",
                    onTap: (controller.isLoading.value)
                        ? () {}
                        : () {
                            FormState state = controller.key.currentState;
                            if (state != null) {
                              if (state.validate()) {
                                controller.ubah(context);
                              }
                            }
                          })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
