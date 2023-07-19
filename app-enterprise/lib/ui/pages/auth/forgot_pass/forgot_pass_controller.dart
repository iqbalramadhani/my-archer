
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/auth/login/login_screen.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

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
    timer = Timer.periodic(
      const Duration(seconds: 1),
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

  void apiForgotPass({required String email, required Function onFinish}) async {
    loadingDialog();

    try{
      final resp = await dio.post(urlForgotPass, data: {
        "email" : email,
      });

      Get.back();

      try {
        if(resp.data['data'] != null){
          onFinish();
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiForgotPass(email : email, onFinish: onFinish());
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "${Translator.failedToRequest.tr} ${_.toString()}" : Translator.failedToRequest.tr;
        showDialogError(msg: msg, onPosClick: (){
          apiForgotPass(email : email, onFinish: onFinish());
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "${Translator.failedToRequest.tr} ${_.toString()}" : Translator.failedToRequest.tr;
      showDialogError(msg: msg, onPosClick: (){
        apiForgotPass(email : email, onFinish: onFinish());
      });
    }
  }

  void apiValidate() async {
    loadingDialog();

    try{
      final resp = await dio.post(urlValidateForgotOtp, data: {
        "email" : email.value,
        "code" : otpCode.value,
      });

      Get.back();

      try {
        if(resp.data['data'] != null){
          currentStep.value += 1;
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiValidate();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "${Translator.failedToRequest.tr} ${_.toString()}" : Translator.failedToRequest.tr;
        showDialogError(msg: msg, onPosClick: (){
          apiValidate();
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "${Translator.failedToRequest.tr} ${_.toString()}" : Translator.failedToRequest.tr;
      showDialogError(msg: msg, onPosClick: (){
        apiValidate();
      });
    }
  }

  void apiResetPass() async {
    if(newPassController.value.text.isEmpty){
      validationPass.value = Translator.passwordMustFill.tr;
    }

    if(confirmNewPassController.value.text.isEmpty){
      validationConfirmPass.value = Translator.confirmPassMustFill.tr;
    }

    if(confirmNewPassController.value.text.isEmpty || newPassController.value.text.isEmpty){
      return;
    }else if(confirmNewPassController.value.text != newPassController.value.text){
      return;
    }

    loadingDialog();

    try{
      final resp = await dio.post(urlResetPassword, data: {
        "email" : email.value,
        "password" : newPassController.value.text,
        "confirm_password" : confirmNewPassController.value.text,
      });

      Get.back();

      try {
        if(resp.data['data'] != null){
          modalBottomDialog(title: Translator.congratsPassChanged.tr, textButton: Translator.login.tr, isDismisable: false, icon: Assets.images.imgUnlock.path, content: Translator.kuyTryLogin.tr,
              onClick: (){
                Get.offAll(()=> const LoginScreen());
              });
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiResetPass();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "${Translator.failedToRequest.tr} ${_.toString()}" : Translator.failedToRequest.tr;
        showDialogError(msg: msg, onPosClick: (){
          apiResetPass();
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "${Translator.failedToRequest.tr} ${_.toString()}" : Translator.failedToRequest.tr;
      showDialogError(msg: msg, onPosClick: (){
        apiResetPass();
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
