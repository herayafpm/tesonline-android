import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tes_online/services/dio_service.dart';
import 'package:tes_online/utils/response_util.dart';

abstract class LupaPasswordRepository {
  static Future<Map<String, dynamic>> proses(String user_username) async {
    try {
      Response response =
          await DioService.init().post("/auth/lupa_password", data: {
        "user_username": user_username,
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

  static Future<Map<String, dynamic>> cek_kode(
      String user_email, int kode_otp) async {
    try {
      Response response =
          await DioService.init().post("/auth/lupa_password/cek_kode", data: {
        "user_email": user_email,
        "kode_otp": kode_otp,
      });
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

  static Future<Map<String, dynamic>> ubah_password(
      String user_email, int kode_otp, String user_password) async {
    try {
      Response response = await DioService.init()
          .post("/auth/lupa_password/ubah_password", data: {
        "user_email": user_email,
        "kode_otp": kode_otp,
        "user_password": user_password,
      });
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
