
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../core/models/response/forgot_pass_response.dart';
import '../../../core/models/response/login_response.dart';
import '../forgot_pass/forgot_pass_screen.dart';
import '../main/main_screen.dart';

class LoginController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxInt currentStep = 0.obs;

  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  RxString validationEmail = "".obs;
  RxString validationPass = "".obs;

  RxBool isShowPass = false.obs;

  initController() async {

  }

  loginAction(){
    if(usernameController.value.text.isEmpty){
      validationEmail.value = "Email harus di isi";
      // errorToast(msg: "Username or Email must fill");
      return;
    }

    validationEmail.value = "";

    if(passwordController.value.text.isEmpty){
      validationPass.value = "Kata sandi harus di isi";
      // errorToast(msg: "Password must fill");
      return;
    }

    validationPass.value = "";

    apiLogin();
  }

  void apiLogin() async {
    loadingDialog();

    try{
      final resp = await dio.post("$urlLogin", data: {
        "email" : usernameController.value.text.toString(),
        "password" : passwordController.value.text.toString()
      });

      Get.back();

      try {
        LoginResponse response = LoginResponse.fromJson(resp.data);
        if(response.data != null){
          box.write(KEY_TOKEN, response.data!.accessToken);
          // box.write(KEY_USER, response.data!.profile);
          goToPage(MainScreen(), dismissPage: true);
        }else if(response.errors != null){
          var error = getErrorMessage(resp);
          if(error.toLowerCase().contains("kata sandi") || error.toLowerCase().contains("password")){
            validationPass.value = error.replaceAll("-", "");
          }
          // errorToast(msg: error);
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    }catch(_){
      Get.back();
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiForgotPass() async {
    loadingDialog();

    try{
      final resp = await dio.post("$urlForgotPass", data: {
        "email" : usernameController.value.text.toString(),
      });

      Get.back();

      try {
        ForgotPassResponse response = ForgotPassResponse.fromJson(resp.data);
        if(response.data != null){
          goToPage(ForgotPassScreen(email: usernameController.value.text,));
        }else if(response.errors != null){
          var msg = getErrorMessage(resp);
          if(msg.contains("Key sudah dikirim ke alamat email anda, mohon cek email anda")){
            goToPage(ForgotPassScreen(email: usernameController.value.text,));
            return;
          }
          errorToast(msg: msg);
        }else if(response.message != null){
          var msg = response.message;
          if(msg!.contains("Key sudah dikirim ke alamat email anda, mohon cek email anda")){
            goToPage(ForgotPassScreen(email: usernameController.value.text,));
            return;
          }
          errorToast(msg: "$msg");
        }
      } catch (_) {
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    }catch(_){
      Get.back();
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
