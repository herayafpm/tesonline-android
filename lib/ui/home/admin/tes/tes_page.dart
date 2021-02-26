import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tes_online/bloc/admin/soal/soal_bloc.dart';
import 'package:tes_online/bloc/admin/test/test_bloc.dart';
import 'package:tes_online/static_data.dart';
import 'package:tes_online/ui/components/error_state.dart';
import 'package:tes_online/utils/toast_util.dart';

class TesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      appBar: AppBar(
        title: Text("User Test"),
      ),
      body: BlocProvider<TestBloc>(
        create: (context) => TestBloc()..add(TestGetListEvent()),
        child: TesView(),
      ),
    );
  }
}

// ignore: must_be_immutable
class TesView extends StatelessWidget {
  TestBloc bloc;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(TestGetListEvent(refresh: true));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(TestGetListEvent());
    _refreshController.loadComplete();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<TestBloc>(context);
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Parent(
            style: ParentStyle()..background.color(Colors.grey[50]),
            child: BlocConsumer<TestBloc, TestState>(
              listener: (context, state) {
                if (state is TestStateError) {
                  ToastUtil.error(message: state.errors['message'] ?? '');
                } else if (state is TestStateSuccess) {
                  ToastUtil.success(message: state.data['message'] ?? '');
                }
              },
              builder: (context, state) {
                if (state is TestListLoaded) {
                  TestListLoaded stateData = state;
                  if (stateData.tests.length > 0) {
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
                        itemCount: stateData.tests.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> test = stateData.tests[index];
                          return Container(
                            margin: EdgeInsets.all(5),
                            child: ListTile(
                              tileColor: Colors.white,
                              title: Text("${test['user_nama']}"),
                              subtitle: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      style: TextStyle(color: Colors.black54),
                                      text:
                                          "Score: ${test['user_test_score']}\n"),
                                  TextSpan(
                                      style: TextStyle(color: Colors.black54),
                                      text:
                                          "Tanggal: ${test['user_test_created_at']}"),
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return ErrorState(
                      title: "User belum melakukan tes",
                      onTap: () {
                        bloc..add(TestGetListEvent(refresh: true));
                      },
                    );
                  }
                }
                return ErrorState(
                  onTap: () {
                    bloc..add(TestGetListEvent(refresh: true));
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
