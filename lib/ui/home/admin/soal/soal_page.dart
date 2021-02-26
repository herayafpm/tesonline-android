import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tes_online/bloc/admin/soal/soal_bloc.dart';
import 'package:tes_online/static_data.dart';
import 'package:tes_online/ui/components/error_state.dart';
import 'package:tes_online/utils/toast_util.dart';

class ManajemenSoalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      appBar: AppBar(
        title: Text("Soal"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed("/admin/soal/tambah");
        },
      ),
      body: BlocProvider<SoalBloc>(
        create: (context) => SoalBloc()..add(SoalGetListEvent()),
        child: ManajemenSoalView(),
      ),
    );
  }
}

// ignore: must_be_immutable
class ManajemenSoalView extends StatelessWidget {
  SoalBloc bloc;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(SoalGetListEvent(refresh: true));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(SoalGetListEvent());
    _refreshController.loadComplete();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SoalBloc>(context);
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Parent(
            style: ParentStyle()..background.color(Colors.grey[50]),
            child: BlocConsumer<SoalBloc, SoalState>(
              listener: (context, state) {
                if (state is SoalStateError) {
                  ToastUtil.error(message: state.errors['message'] ?? '');
                } else if (state is SoalStateSuccess) {
                  ToastUtil.success(message: state.data['message'] ?? '');
                }
              },
              builder: (context, state) {
                if (state is SoalListLoaded) {
                  SoalListLoaded stateData = state;
                  if (stateData.soals.length > 0) {
                    return SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropMaterialHeader(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView.builder(
                        itemCount: stateData.soals.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> soal = stateData.soals[index];
                          return Container(
                            margin: EdgeInsets.all(5),
                            child: ListTile(
                              leading: soal['soal_status'] == '1'
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.greenAccent,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                    ),
                              trailing: PopupMenuButton<String>(
                                onSelected: (choice) {
                                  if (choice == "Edit") {
                                    Get.toNamed("/admin/soal/edit",
                                        arguments: {"id": soal['soal_id']});
                                  } else if (choice == "Aktifkan") {
                                    bloc
                                      ..add(SoalSetStatusEvent(
                                          int.parse(soal['soal_id']), 1));
                                  } else if (choice == "Matikan") {
                                    bloc
                                      ..add(SoalSetStatusEvent(
                                          int.parse(soal['soal_id']), 0));
                                  } else if (choice == "Hapus") {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Hapus Soal"),
                                              content: Text(
                                                  "Yakin ingin menghapus soal ini?"),
                                              actions: [
                                                FlatButton(
                                                  child: Text("Batal"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("Ya"),
                                                  onPressed: () {
                                                    bloc
                                                      ..add(SoalDeleteEvent(
                                                          int.parse(soal[
                                                              'soal_id'])));
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ));
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    "Edit",
                                    "Aktifkan",
                                    "Matikan",
                                    "Hapus"
                                  ].map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                              ),
                              tileColor: Colors.white,
                              title: Text("${soal['soal_isi']}"),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return ErrorState(
                      title: "Anda belum menambahkan soal",
                      onTap: () {
                        bloc..add(SoalGetListEvent(refresh: true));
                      },
                    );
                  }
                }
                return ErrorState(
                  onTap: () {
                    bloc..add(SoalGetListEvent(refresh: true));
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
