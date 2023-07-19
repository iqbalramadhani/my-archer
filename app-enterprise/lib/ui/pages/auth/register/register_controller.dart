

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/core/models/objects/region_model.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/auth/login/login_screen.dart';
import 'package:myarcher_enterprise/ui/pages/main/main_screen.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class RegisterController extends GetxController {
  var box = GetStorage();

  ///first form
  Rx<TextEditingController> nameC = TextEditingController().obs;
  Rx<TextEditingController> emailC = TextEditingController().obs;
  Rx<TextEditingController> phoneC = TextEditingController().obs;
  Rx<TextEditingController> provinceC = TextEditingController().obs;
  Rx<TextEditingController> cityC = TextEditingController().obs;

  ///second form
  Rx<TextEditingController> whereKnowC = TextEditingController().obs;
  Rx<TextEditingController> whyUseC = TextEditingController().obs;
  Rx<TextEditingController> activityUsuallC = TextEditingController().obs;
  Rx<TextEditingController> activityNearbyC = TextEditingController().obs;
  Rx<TextEditingController> descActivityC = TextEditingController().obs;

  ///third form
  Rx<TextEditingController> passC = TextEditingController().obs;
  Rx<TextEditingController> confirmPassC = TextEditingController().obs;

  Rx<RegionModel> selectedProvince = RegionModel().obs;
  Rx<RegionModel> selectedCity = RegionModel().obs;

  Dio dio = ApiServices().launch();

  RxInt stateView = 0.obs;
  RxBool isLoadingCheck = false.obs;

  RxBool isShowPass = false.obs;
  RxBool isShowConfirmPass = false.obs;

  ///1st form validation
  RxString errorName = "".obs;
  RxString errorEmail = "".obs;
  RxString errorPhone = "".obs;
  RxString errorPass = "".obs;
  RxString errorConfirmPass = "".obs;

  ///2nd form validation
  RxString errorProvince = "".obs;
  RxString errorCity = "".obs;
  RxString errorWhere = "".obs;
  RxString errorWhy = "".obs;
  RxString errorWhatUsuall = "".obs;
  RxString errorWhatNearby = "".obs;
  RxString errorDescNearby = "".obs;


  initController() async {
  }

  bool isValid(){
    if(stateView.value == 0){

      if(nameC.value.text.isEmpty){
        errorName.value = Translator.nameMustFill.tr;
      }

      if(emailC.value.text.isEmpty){
        errorEmail.value = Translator.emailMustFill.tr;
      }

      if(phoneC.value.text.isEmpty){
        errorPhone.value = Translator.phoneMustFill.tr;
      }

      if(passC.value.text.isEmpty){
        errorPass.value = Translator.passwordMustFill.tr;
      }

      if(confirmPassC.value.text.isEmpty){
        errorConfirmPass.value = Translator.confirmPassMustFill.tr;
      }



      if(errorName.value.isEmpty &&
          errorEmail.value.isEmpty &&
          errorPhone.value.isEmpty &&
          errorPass.value.isEmpty &&
          errorConfirmPass.value.isEmpty
          ){
        return true;
      }

      return false;
    }else if(stateView.value == 1){

      if(provinceC.value.text.isEmpty){
        errorProvince.value = Translator.provinceMustFill.tr;
      }

      if(cityC.value.text.isEmpty){
        errorCity.value = Translator.cityMustFill.tr;
      }


      if(whereKnowC.value.text.isEmpty){
        errorWhere.value = Translator.cantEmpty.tr;
      }

      if(whyUseC.value.text.isEmpty){
        errorWhy.value = Translator.cantEmpty.tr;
      }

      if(activityUsuallC.value.text.isEmpty){
        errorWhatUsuall.value = Translator.cantEmpty.tr;
      }

      if(activityNearbyC.value.text.isEmpty){
        errorWhatNearby.value = Translator.cantEmpty.tr;
      }

      if(descActivityC.value.text.isEmpty){
        errorDescNearby.value = Translator.cantEmpty.tr;
      }

      if(selectedProvince.value.id != null && selectedCity.value.id != null &&
          errorWhere.value.isEmpty &&
          errorWhy.value.isEmpty &&
          errorWhatUsuall.value.isEmpty &&
          errorWhatNearby.value.isEmpty &&
          errorDescNearby.value.isEmpty){
        return true;
      }

      return false;
    }

    return false;
  }

  void apiRegister() async {
    loadingDialog();

    var body = {
      "name_organizer" : nameC.value.text,
      "email" : emailC.value.text,
      "password" : passC.value.text,
      "password_confirmation" : confirmPassC.value.text,
      "phone_number" : phoneC.value.text,
      "province_id" : selectedProvince.value.id,
      "city_id" : selectedCity.value.id,
      "intro" : {
        "where" : whereKnowC.value.text,
        "why" : whyUseC.value.text,
        "venue_activity" : activityUsuallC.value.text,
        "what" : activityNearbyC.value.text,
        "description" : descActivityC.value.text,
      }
    };

    try{
      final resp = await dio.post(urlRegister, data: body);

      Get.back();

      try {
        // BaseResponse response = BaseResponse.fromJson(resp.data);
        if(resp.statusCode.toString().startsWith("2")){
          var data = resp.data['data'];
          box.write(KeyValue.keyToken, data['accessToken']);
          Get.offAll(()=> const MainScreen(from: "register",));
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiRegister();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiRegister();
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiRegister();
      });
    }
  }

  void apiCheckEmail({required String email}) async {
    isLoadingCheck.value = true;

    try{
      final resp = await dio.get(urlCheckEmail, queryParameters: {
        "email" : email
      });

      isLoadingCheck.value = false;

      try {
        if(resp.data['data'] != null){
          if(resp.data['data']['isRegistered']){
            showConfirmDialog(Get.context!,
                showIcon: true,
                content: Translator.emailAlreadyRegistered.tr,
                assets: Assets.icons.icAlert,
                dismissable: false,
                typeAsset: "svg",
                btn2: Translator.close.tr, onClickBtn2: () {
                  emailC.value.text = "";
                },
                btn3: Translator.login.tr, onClickBtn3: () {
                  Get.offAll(()=> LoginScreen(email: email,));
                });
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiCheckEmail(email: email);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiCheckEmail(email: email);
        });
      }
    }catch(_){
      isLoadingCheck.value = false;
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiCheckEmail(email: email);
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
