// import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/key_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../ui/pages/main/main_controller.dart';

class ApiServices {
  final box = GetStorage();
  // Alice alice = Alice(
  //     showNotification: true,
  //     showShareButton: true,
  //     showInspectorOnShake: true,
  //     notificationIcon: "@mipmap/launcher_icon",
  //     navigatorKey: navigatorKey
  // );

  Dio launch() {
    Dio dio = new Dio();
    if(isTesting()) {
      // dio.interceptors.add(alice.getDioInterceptor());
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
    print("token auth ${box.read(KEY_TOKEN)}");
    if(box.read(KEY_TOKEN) != null){
      dio.options.headers["Authorization"] = 'Bearer ${box.read(KEY_TOKEN)}';
    }
    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      if(s! == 401){
        // print("401 ini cuy");
        var controller = MainController();
        controller.logoutAction();
        return false;
      }
      return s < 500;
    };

    return dio;
  }
}
