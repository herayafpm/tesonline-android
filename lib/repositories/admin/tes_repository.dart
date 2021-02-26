import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tes_online/services/dio_service.dart';
import 'package:tes_online/utils/response_util.dart';

abstract class TesRepository {
  static Future<Map<String, dynamic>> getListTes(
      {int limit = 10, int offset = 0}) async {
    try {
      Dio dio = await DioService.withToken();
      Response response =
          await dio.get("/admin/test?limit=$limit&offset=$offset");
      Map<String, dynamic> data = Map<String, dynamic>();
      data['statusCode'] = response.statusCode;
      data['data'] = response.data;
      return data;
    } on SocketException catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.message);
    } on DioError catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.message);
    } catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.toString());
    }
  }
}
