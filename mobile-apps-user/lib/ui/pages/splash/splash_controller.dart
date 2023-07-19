import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../login/login_screen.dart';
import '../main/main_screen.dart';

class SplashController extends GetxController {
  var box = GetStorage();
  RxInt currentYear = 2022.obs;

  initController() async {
    await getDeviceInfo();
    box.write(KEY_USER, null);
    nextPage();

    currentYear.value = int.parse(getCurrentFormatedTime("yyyy"));
  }

  getDeviceInfo() async{
    if(GetPlatform.isAndroid){
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      box.write(KEY_APP_PLATFORM_VERSION, "Android ${androidInfo.version.release}");
    }else{
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      box.write(KEY_APP_PLATFORM_VERSION, "${iosInfo.systemName} ${iosInfo.systemVersion}");
    }
    
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    box.write(KEY_APP_VERSION, packageInfo.buildNumber);

  }

  void nextPage() {
    var duration = const Duration(seconds: 2);
    Timer(duration, () {
      box.read(KEY_TOKEN) != null ? Get.offAll(()=> const MainScreen()) : Get.offAll(()=> const LoginScreen());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
