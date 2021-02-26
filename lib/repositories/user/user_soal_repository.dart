import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tes_online/services/dio_service.dart';
import 'package:tes_online/utils/response_util.dart';

abstract class UserSoalRepository {
  static Future<Map<String, dynamic>> getSoals() async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.get("/user/soal");
      Map<String, dynamic> data = Map<String, dynamic>();
      data['statusCode'] = response.statusCode;
      data['data'] = response.data;
      print("data $response");
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

  static Future<Map<String, dynamic>> getSoal(int id) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.get("/user/soal/$id");
      Map<String, dynamic> data = Map<String, dynamic>();
      data['statusCode'] = response.statusCode;
      data['data'] = response.data;
      print("data $response");
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
