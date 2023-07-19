import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/core/models/objects/profile_model.dart';
import 'package:myarcher_enterprise/core/models/responses/profile_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/ui/pages/auth/login/login_screen.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';

class ProfileController extends GetxController {
  var box = GetStorage();
  var dio = ApiServices().launch();

  Rx<ProfileModel> profile = ProfileModel().obs;

  void apiGetProfile({Function? onFinish}) async {
    try{
      final resp = await dio.get(urlProfile);

      checkLogin(resp);

      try {
        ProfileResponse response = ProfileResponse.fromJson(resp.data);
        if(response.data != null){
          box.write(KeyValue.keyUser, response.data);
          if(onFinish != null) onFinish();
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiGetProfile();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiGetProfile();
        });
      }
    }catch(_){
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiGetProfile();
      });
    }
  }

  void logout(){
    var box = GetStorage();
    box.write(KeyValue.keyToken, null);
    box.write(KeyValue.keyUser, null);

    Get.offAll(()=> const LoginScreen());
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
