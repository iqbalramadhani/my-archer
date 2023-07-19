
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

import '../../../core/models/response/login_response.dart';

class RegisterController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();
  Rx<PageController> pageController = PageController().obs;

  RxString validationNama = "".obs;
  RxString validationBirthdate = "".obs;
  RxString validationEmail = "".obs;
  RxString validationPass = "".obs;
  RxString validationConfirmPass = "".obs;

  RxString selectedGender = "L".obs;

  RxBool isShowPass = false.obs;
  RxBool isShowConfirmPass = false.obs;

  RxInt currentStep = 0.obs;

  Rx<TextEditingController> fullNameTxtController = TextEditingController().obs;
  Rx<TextEditingController> birthDateTxtController = TextEditingController().obs;
  Rx<TextEditingController> emailTxtController = TextEditingController().obs;
  Rx<TextEditingController> passwordTxtController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordTxtController = TextEditingController().obs;

  initController() async {

  }

  registerAction(){
    if(emailTxtController.value.text.isEmpty){
      validationEmail.value = "Email tidak boleh kosong";
      return;
    }

    validationEmail.value = "";

    if(passwordTxtController.value.text.isEmpty){
      validationPass.value = "Kata Sandi tidak boleh kosong";
      return;
    }

    validationPass.value = "";

    if(confirmPasswordTxtController.value.text.isEmpty){
      validationConfirmPass.value = "Konfirmasi Kata Sandi tidak boleh kosong";
      return;
    }

    validationConfirmPass.value = "";

    if(passwordTxtController.value.text != confirmPasswordTxtController.value.text){
      validationPass.value = "Kata Sandi tidak sama";
      validationConfirmPass.value = "Kata Sandi tidak sama";
      return;
    }

    validationPass.value = "";
    validationConfirmPass.value = "";

    apiRegister();
  }

  void apiRegister() async {
    loadingDialog();

    try{
      final resp = await dio.post("$urlRegister", data: {
        "name" : fullNameTxtController.value.text.toString(),
        "email" : emailTxtController.value.text.toString(),
        "password" : passwordTxtController.value.text.toString(),
        "date_of_birth" : birthDateTxtController.value.text.toString(),
        "gender" : selectedGender.value == "L" ? "male" : "female",
        "password_confirmation" : passwordTxtController.value.text.toString(),
        "club" : null,
      });

      Get.back();

      try {
        LoginResponse response = LoginResponse.fromJson(resp.data);
        if(response.data != null){
          box.write(KEY_TOKEN, response.data!.accessToken);
          currentStep.value += 1;
          pageController.value.animateToPage(currentStep.value, curve: Curves.easeIn, duration: Duration(milliseconds: 500));
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
