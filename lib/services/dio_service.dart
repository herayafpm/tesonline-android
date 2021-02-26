import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tes_online/models/user_model.dart';
import 'package:tes_online/static_data.dart';

abstract class DioService {
  static Dio init() {
    Dio dio = new Dio();
    dio.options.baseUrl = StaticData.baseUrl;
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 3000;
    dio.options.validateStatus = (_) => true;
    dio.options.responseType = ResponseType.json;
    return dio;
  }

  static Future<Dio> withToken() async {
    Dio dio = new Dio();
    dio.options.baseUrl = StaticData.baseUrl;
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 15000;
    dio.options.validateStatus = (_) => true;
    dio.options.responseType = ResponseType.json;
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      dio.interceptors.requestLock.lock();
      var usermodelBox = await Hive.openBox("user_model");
      UserModel user = usermodelBox.getAt(0);
      //Set the token to headers
      options.contentType = "application/json;charset=UTF-8";
      options.headers["X-Auth"] = "Bearer " + user.token;
      dio.interceptors.requestLock.unlock();
      return options; //continue
    }));
    return dio;
  }
}
