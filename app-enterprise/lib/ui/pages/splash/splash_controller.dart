import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/ui/pages/auth/login/login_screen.dart';
import 'package:myarcher_enterprise/ui/pages/main/main_screen.dart';
import 'package:myarcher_enterprise/utils/date_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  var box = GetStorage();
  RxInt currentYear = 2022.obs;

  initController() async {
    await getDeviceInfo();
    nextPage();

    currentYear.value = int.parse(DateHelper().getCurrentFormatedTime("yyyy"));
  }

  getDeviceInfo() async{
    if(GetPlatform.isAndroid){
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      box.write(KeyValue.keyAppPlatformVersion, "Android ${androidInfo.version.release}");
    }else{
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      box.write(KeyValue.keyAppPlatformVersion, "${iosInfo.systemName} ${iosInfo.systemVersion}");
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    box.write(KeyValue.keyAppVersion, packageInfo.buildNumber);

  }

  void nextPage() {
    var duration = const Duration(seconds: 2);
    Timer(duration, () {
      box.read(KeyValue.keyToken) != null ? Get.off(()=> const MainScreen()) : Get.off(()=> const LoginScreen());
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
