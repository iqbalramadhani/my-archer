// import 'package:alice/alice.dart';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/main.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServices {
  final box = GetStorage();
  Alice alice = Alice(
      showNotification: true,
      showShareButton: true,
      showInspectorOnShake: true,
      notificationIcon: "@mipmap/launcher_icon",
      navigatorKey: navigatorKey
  );

  Dio launch() {
    Dio dio = new Dio();
    if(baseUrl.toLowerCase().contains("staging")) {
      dio.interceptors.add(alice.getDioInterceptor());
    }
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 1000));

    dio.options.headers["accept"] = 'application/json';
    if(box.read(KeyValue.keyToken) != null){
      dio.options.headers["Authorization"] = 'Bearer ${box.read(KeyValue.keyToken)}';
    }

    dio.options.headers["X-Platform"] = GetPlatform.isIOS ? "iOS" : "Android";
    dio.options.headers["X-Platform-Version"] = "${box.read(KeyValue.keyAppPlatformVersion)}";
    dio.options.headers["X-App-Version"] = "${box.read(KeyValue.keyAppVersion)}";

    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      return s! < 500;
    };

    return dio;
  }
}
