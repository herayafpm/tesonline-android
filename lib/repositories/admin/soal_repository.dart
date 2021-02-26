import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tes_online/services/dio_service.dart';
import 'package:tes_online/utils/response_util.dart';

abstract class SoalRepository {
  static Future<Map<String, dynamic>> getListSoal(
      {int limit = 10, int offset = 0}) async {
    try {
      Dio dio = await DioService.withToken();
      Response response =
          await dio.get("/admin/soal?limit=$limit&offset=$offset");
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

  static Future<Map<String, dynamic>> getSoal(int id) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.get("/admin/soal/$id");
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

  static Future<Map<String, dynamic>> postSoal(
      Map<String, dynamic> json) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.post("/admin/soal", data: json);
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

  static Future<Map<String, dynamic>> putSoal(
      int id, Map<String, dynamic> soal) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.put("/admin/soal/$id", data: soal);
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

  static Future<Map<String, dynamic>> deleteSoal(int id) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.delete("/admin/soal/$id");
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

  static Future<Map<String, dynamic>> setStatus(int id, int status) async {
    try {
      Dio dio = await DioService.withToken();
      Response response =
          await dio.get("/admin/soal/set_status/$id?status=$status");
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
