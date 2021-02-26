import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tes_online/bloc/user/user_soal/user_soal_bloc.dart';
import 'package:tes_online/bloc/user/user_test/user_test_bloc.dart';
import 'package:tes_online/controllers/home/tes_controller.dart';
import 'package:tes_online/static_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_online/ui/components/my_button.dart';
import 'package:tes_online/utils/toast_util.dart';

class TestPage extends StatelessWidget {
  final controller = Get.put(TesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: StaticData.bgColor,
          title: Text("Tes Online 129"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocProvider(
              create: (context) => UserTestBloc(),
              child: BlocListener<UserTestBloc, UserTestState>(
                  listener: (context, state) {
                    if (state is UserTestStateSuccess) {
                      ToastUtil.success(message: state.data['message'] ?? '');
                      Get.offNamedUntil("/home", ModalRoute.withName('/home'));
                    }
                  },
                  child: BlocProvider(
                    create: (context) =>
                        UserSoalBloc()..add(UserSoalsGetEvent()),
                    child: BlocConsumer<UserSoalBloc, UserSoalState>(
                      listener: (context, state) {
                        if (state is UserSoalsStateSuccess) {
                          controller.soal_ids.assignAll(state.data['data']);
                          controller.jawabans.assignAll(
                              (state.data['data'] as List<dynamic>)
                                  .map((e) => ""));
                          BlocProvider.of<UserSoalBloc>(context)
                            ..add(UserSoalGetEvent(int.parse(controller
                                .soal_ids[controller.activeSoal.value])));
                        }
                      },
                      builder: (context, state) {
                        if (state is UserSoalStateSuccess) {
                          Map<String, dynamic> soal = state.data['data'];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                "${soal['soal_isi']}",
                                style: TxtStyle()..fontSize(16.ssp),
                              ),
                              Obx(() => controller.itemCheckbox(
                                  "${soal['jawaban_a']}",
                                  controller.jawabans.length >=
                                          controller.activeSoal.value
                                      ? controller.jawabans[
                                              controller.activeSoal.value] ==
                                          'a'
                                      : false,
                                  "a")),
                              Obx(() => controller.itemCheckbox(
                                  "${soal['jawaban_b']}",
                                  controller.jawabans.length >=
                                          controller.activeSoal.value
                                      ? controller.jawabans[
                                              controller.activeSoal.value] ==
                                          'b'
                                      : false,
                                  "b")),
                              Obx(() => controller.itemCheckbox(
                                  "${soal['jawaban_c']}",
                                  controller.jawabans.length >=
                                          controller.activeSoal.value
                                      ? controller.jawabans[
                                              controller.activeSoal.value] ==
                                          'c'
                                      : false,
                                  "c")),
                              Obx(() => controller.itemCheckbox(
                                  "${soal['jawaban_d']}",
                                  controller.jawabans.length >=
                                          controller.activeSoal.value
                                      ? controller.jawabans[
                                              controller.activeSoal.value] ==
                                          'd'
                                      : false,
                                  "d")),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => controller.activeSoal.value > 0
                                      ? FlatButton(
                                          child: Text("Kembali"),
                                          onPressed: () {
                                            controller.backSoal(context);
                                          },
                                        )
                                      : Container()),
                                  Obx(() => controller.activeSoal.value <
                                          controller.soal_ids.length - 1
                                      ? FlatButton(
                                          child: Text("Selanjutnya"),
                                          onPressed: () {
                                            controller.nextSoal(context);
                                          },
                                        )
                                      : Container()),
                                ],
                              ),
                              SizedBox(
                                height: 0.02.sh,
                              ),
                              Obx(() => (controller.activeSoal.value ==
                                      controller.soal_ids.length - 1)
                                  ? Obx(() => Center(
                                        child: MyButton(
                                          isLoading: controller.isLoading.value,
                                          title: "Simpan",
                                          onTap: (controller.isLoading.value)
                                              ? () {}
                                              : () {
                                                  controller.proses(context);
                                                },
                                        ),
                                      ))
                                  : Container())
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  )),
            )));
  }
}
