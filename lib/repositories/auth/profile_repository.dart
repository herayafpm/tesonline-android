import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tes_online/services/dio_service.dart';
import 'package:tes_online/utils/response_util.dart';

abstract class ProfileRepository {
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.get("/auth/profile");
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

  static Future<Map<String, dynamic>> ubah_profile(
      Map<String, dynamic> user) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.put("/auth/profile", data: user);
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

  static Future<Map<String, dynamic>> ubah_fcm(String user_fcm) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.put("/auth/ubah_fcm_token", data: {
        "user_fcm": user_fcm,
      });
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

  static Future<Map<String, dynamic>> ubah_password(
      String user_password) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.put("/auth/ubah_password", data: {
        "user_password": user_password,
      });
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
