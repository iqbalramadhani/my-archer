

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/core/models/responses/login_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/ui/pages/main/main_screen.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class LoginController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();


  ///text controller
  Rx<TextEditingController> emailC = TextEditingController().obs;
  Rx<TextEditingController> passC = TextEditingController().obs;

  RxBool isShowPass = false.obs;

  ///error message form
  RxString errorEmail = "".obs;
  RxString errorPass = "".obs;

  initController() async {
  }

  loginAction(){
    if(emailC.value.text.isEmpty){
      Toast().errorToast(msg: Translator.emailMustFill.tr);
      return;
    }

    if(passC.value.text.isEmpty){
      Toast().errorToast(msg: Translator.passwordMustFill.tr);
      return;
    }

    apiLogin();
  }

  void apiLogin() async {
    loadingDialog();

    var body = {
      "email" : emailC.value.text.toString(),
      "password" : passC.value.text.toString(),
      "login_from" : "enterprise",
    };

    try{
      final resp = await dio.post(urlLogin, data: body);

      Get.back();

      try {
        LoginResponse response = LoginResponse.fromJson(resp.data);
        if(response.data != null){
          box.write(KeyValue.keyToken, response.data!.accessToken);
          box.write(KeyValue.keyUser, response.data!.profile);
          Get.offAll(()=> const MainScreen());
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiLogin();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiLogin();
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiLogin();
      });
    }
  }
  @override
  void onClose() {
    super.onClose();
  }
}
