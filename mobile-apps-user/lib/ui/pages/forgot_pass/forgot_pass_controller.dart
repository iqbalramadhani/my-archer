
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../core/models/response/forgot_pass_response.dart';

class ForgotPassController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxBool isValid = false.obs;
  RxInt requestOtp = 1.obs;

  var otpCode = "".obs;
  Timer? timer;
  RxInt countdown = 60.obs;

  RxInt currentStep = 0.obs;
  RxString email = "".obs;
  RxString emailAsterix = "".obs;

  Rx<TextEditingController> pinController = TextEditingController().obs;
  Rx<TextEditingController> newPassController = TextEditingController().obs;
  Rx<TextEditingController> confirmNewPassController = TextEditingController().obs;

  RxString validationEmail = "".obs;
  RxString validationPass = "".obs;
  RxString validationConfirmPass = "".obs;

  RxBool isShowPass = false.obs;
  RxBool isShowConfirmPass = false.obs;

  initController() async {
    hideSomeChar();
    startTimer();
  }

  startTimer() {
    isValid.value = false;
    timer = new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) {
        if (countdown.value == 0) {
          timer.cancel();
        } else {
          countdown--;
        }
      },
    );
  }

  resetTimer(){
    countdown.value = 60;
    startTimer();
  }

  hideSomeChar(){
    try{
      var emailFirst = email.value.split("@");
      emailAsterix.value = "${emailFirst[0].replaceRange(1, emailFirst[0].length - 2, "*" * (emailFirst[0].length-2))}@${emailFirst[1]}";
    }catch(e){
      emailAsterix.value = email.value;
    }
  }

  void apiForgotPass() async {
    loadingDialog();

    try{
      final resp = await dio.post("$urlForgotPass", data: {
        "email" : email.value,
      });

      Get.back();

      try {
        ForgotPassResponse response = ForgotPassResponse.fromJson(resp.data);
        if(response.data != null){
          resetTimer();
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
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

  void apiValidate() async {
    loadingDialog();

    try{
      final resp = await dio.post("$urlValidateForgotOtp", data: {
        "email" : email.value,
        "code" : otpCode.value,
      });

      Get.back();

      try {
        ForgotPassResponse response = ForgotPassResponse.fromJson(resp.data);
        if(response.data != null){
          currentStep.value += 1;
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
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

  void apiResetPass() async {
    if(newPassController.value.text.isEmpty){
      validationPass.value = "Kata Sandi tidak boleh kosong";
    }

    if(confirmNewPassController.value.text.isEmpty){
      validationConfirmPass.value = "Konfirmasi Kata Sandi tidak boleh kosong";
    }

    if(confirmNewPassController.value.text.isEmpty || newPassController.value.text.isEmpty){
      return;
    }else if(confirmNewPassController.value.text != newPassController.value.text){
      return;
    }

    loadingDialog();

    try{
      final resp = await dio.post("$urlResetPassword", data: {
        "email" : email.value,
        "password" : newPassController.value.text,
        "confirm_password" : confirmNewPassController.value.text,
      });
      checkLogin(resp);
      Get.back();

      try {
        ForgotPassResponse response = ForgotPassResponse.fromJson(resp.data);
        if(response.data != null){
          currentStep.value += 1;
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
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

  @override
  void onClose() {
    super.onClose();
  }
}
