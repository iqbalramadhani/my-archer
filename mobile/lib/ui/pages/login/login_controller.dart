
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/services/api_services.dart';
import 'package:my_archery/ui/pages/login/login_screen.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/endpoint.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/key_storage.dart';

import '../../../core/models/response/response.dart';
import '../main/main_screen.dart';

class LoginController extends GetxController {
  var box = GetStorage();
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Dio dio = ApiServices().launch();
  String email = "proarchery.rcd@gmail.com";
  String pass = "12345678";

  initController() async {
    if(isTesting()){
      usernameController.value.text = email;
      passwordController.value.text = pass;
    }
  }

  loginAction(){
    if(usernameController.value.text.isEmpty){
      errorToast(msg: "Username or Email must fill");
      return;
    }

    if(passwordController.value.text.isEmpty){
      errorToast(msg: "Password must fill");
      return;
    }

    apiLogin();
  }

  void apiLogin() async {
    loadingDialog();

    // var body = {
    //   "email" : usernameController.value.text.toString(),
    //   "password" : passwordController.value.text.toString()
    // };

    var body = {
      "email" : email,
      "password" : pass
    };

    try{
      final resp = await dio.post("$urlLogin", data: body);

      Get.back();

      try {
        LoginResponse response = LoginResponse.fromJson(resp.data);
        if(response.data != null){
          box.write(KEY_TOKEN, response.data!.accessToken);
          box.write(KEY_USER, response.data!.profile);
          goToPage(MainScreen(), dismissPage: true);
        }else if(response.errors != null){
          // errorToast(msg: getErrorMessage(resp));
          showConfirmDialog(Get.context!, content: getErrorMessage(resp), btn1: "Tutup", btn3: "Login Manual", onClickBtn1: (){
            exit(0);
          }, onClickBtn3: (){
            Get.offAll(()=> const LoginScreen());
          });
        }else if(response.message != null){
          // errorToast(msg: "${response.message}");
          showConfirmDialog(Get.context!, content: response.message, btn1: "Tutup", btn3: "Login Manual", onClickBtn1: (){
            exit(0);
          }, onClickBtn3: (){
            Get.offAll(()=> const LoginScreen());
          });
        }
      } catch (_) {
        printLog(msg: "error api scan qr => ${_.toString()}");
        var msg = "Terjadi kesalahan. Harap ulangi kembali";
        if(kDebugMode){
          msg    = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
        }
        // errorToast(msg: msg);
        showConfirmDialog(Get.context!, content: msg, btn1: "Tutup", btn3: "Login Manual", onClickBtn1: (){
          exit(0);
        }, onClickBtn3: (){
          Get.offAll(()=> const LoginScreen());
        });
      }
    }catch(_){
      Get.back();
      printLog(msg: "error api scan qr => ${_.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if(kDebugMode){
        msg    = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
      }
      // errorToast(msg: msg);

      showConfirmDialog(Get.context!, content: msg, btn1: "Tutup", btn3: "Login Manual", onClickBtn1: (){
        exit(0);
      }, onClickBtn3: (){
        Get.offAll(()=> const LoginScreen());
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
