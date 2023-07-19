import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../main.dart';
import '../../ui/pages/main/home_screen/home_controller.dart';

class ApiServices {
  final box = GetStorage();
  Alice alice = Alice(
    showNotification: true,
    showShareButton: true,
    showInspectorOnShake: true,
    darkTheme: true,
    navigatorKey: navigatorKey
  );
  Dio launch() {
    Dio dio = new Dio();
    if(baseUrl.contains("staging")) {
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

    dio.options.headers["X-Platform"] = GetPlatform.isIOS ? "iOS" : "Android";
    dio.options.headers["X-Platform-Version"] = "${box.read(KEY_APP_PLATFORM_VERSION)}";
    dio.options.headers["X-App-Version"] = "${box.read(KEY_APP_VERSION)}";

    printLog(msg: "token auth ${box.read(KEY_TOKEN)}");
    if(box.read(KEY_TOKEN) != null){
      dio.options.headers["Authorization"] = 'Bearer ${box.read(KEY_TOKEN)}';
    }
    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      if(s! == 401){
        // print("401 ini cuy");
        var controller = HomeController();
        controller.logoutAction();
        return false;
      }
      return s < 500;
    };

    return dio;
  }
}
