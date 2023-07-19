import 'dart:io';

import 'package:dio/dio.dart';
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

import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/objects/region_model.dart';
import '../../../../core/models/response/base_response.dart';
import '../../../../core/models/response/get_verify_data_response.dart';
import '../../complete_verify/complete_verify_screen.dart';

class VerifyController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  Rx<ProfileModel> user = ProfileModel().obs;
  RxBool isLoadingGetData = false.obs;

  RxString selectedGender = "L".obs;
  RxString selectedDateBirth = "".obs;
  var nameTxtCtrl = TextEditingController().obs;
  var birthDateTxtCtrl = TextEditingController().obs;
  var phoneTxtCtrl = TextEditingController().obs;
  var addressTxtCtrl = TextEditingController().obs;
  var nikTxtCtrl = TextEditingController().obs;
  var provTxtCtrl = TextEditingController().obs;
  var cityTxtCtrl = TextEditingController().obs;
  var selectedKtpPhoto = "".obs;
  // var selectedSelfiePhoto = "".obs;

  var errorNik = "".obs;
  var errorAddress = "".obs;
  var errorProvince = "".obs;
  var errorCity = "".obs;
  var errorKtp = "".obs;
  // var errorSelfie = "".obs;

  RxBool isLoadingProvince = false.obs;
  RxBool isLoadingCity = false.obs;

  RxInt currentPageProvince = 1.obs;
  RxInt currentPageCity = 1.obs;

  RxBool validLoadMoreCity = false.obs;
  RxBool validLoadMoreProvince = false.obs;

  Rx<RegionModel> selectedProvince = RegionModel().obs;
  Rx<RegionModel> selectedCity = RegionModel().obs;

  RxBool btnIsValid = false.obs;

  initController(){
    getCurrentData();
  }
  
  getCurrentData(){
    if(box.read(KEY_USER) != null){
      try {
        user.value = box.read(KEY_USER);
      } catch (_) {
        user.value = ProfileModel.fromJson(box.read(KEY_USER));
      }
    }

    nameTxtCtrl.value.text = user.value.name ?? "";
    birthDateTxtCtrl.value.text = user.value.dateOfBirth != null ? convertDateFormat("yyyy-MM-dd", "dd/MM/yyyy", user.value.dateOfBirth!) : "";
    selectedDateBirth.value = user.value.dateOfBirth ?? "";
    selectedGender.value = user.value.gender == null ? "L" : user.value.gender!.toLowerCase() == "female" ? "P" : "L";
    phoneTxtCtrl.value.text = user.value.phoneNumber ?? "";
  }

  checkBtnIsValid(){
    btnIsValid.value = errorNik.value.isEmpty && errorProvince.value.isEmpty && errorCity.value.isEmpty && errorKtp.value.isEmpty && errorAddress.value.isEmpty;
        // && errorSelfie.value.isEmpty;
  }

  validating(){
    if(nikTxtCtrl.value.text.isEmpty){
      errorNik.value = "NIK Tidak boleh kosong";
    }else{
      if(nikTxtCtrl.value.text.length < 16){
        errorNik.value = "NIK kurang dari 16 angka";
      }else
        errorNik.value = "";
    }

    // if(selectedSelfiePhoto.value.isEmpty){
    //   errorSelfie.value = "Foto belum dipilih";
    // }else{
    //   errorSelfie.value = "";
    // }

    if(selectedKtpPhoto.value.isEmpty){
      errorKtp.value = "Foto belum dipilih";
    }else{
      errorKtp.value = "";
    }

    if(addressTxtCtrl.value.text.isEmpty){
      errorAddress.value = "Alamat tidak boleh kosong";
    }else{
      errorAddress.value = "";
    }

    if(provTxtCtrl.value.text.isEmpty){
      errorProvince.value = "Provinsi tidak boleh kosong";
    }else{
      errorProvince.value = "";
    }

    if(cityTxtCtrl.value.text.isEmpty){
      errorCity.value = "Kota/Kabupaten tidak boleh kosong";
    }else{
      errorCity.value = "";
    }

    checkBtnIsValid();
  }

  void apiSendVerifyReq() async {
    loadingDialog();

    try{
      final resp = await dio.put("$urlUpdateVerify", queryParameters: {
        "user_id" : user.value.id
      }, data: {
        "name" : nameTxtCtrl.value.text.toString(),
        "address" : addressTxtCtrl.value.text.toString(),
        "ktp_kk" : convertImagetoBase64(File(selectedKtpPhoto.value)),
        // "selfie_ktp_kk" : convertImagetoBase64(File(selectedSelfiePhoto.value)),
        "nik" : nikTxtCtrl.value.text.toString(),
        "province_id" : selectedProvince.value.id,
        "city_id" : selectedCity.value.id,
      });
      checkLogin(resp);
      Get.back();

      try {
        BaseResponse response = BaseResponse.fromJson(resp.data);
        if(response.errors == null){
          goToPage(CompleteVerifyScreen(), dismissAllPage: true);
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: _.toString());
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    }catch(_){
      Get.back();
      printLog(msg: "${_.toString()}");
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetDataVerify(String userId, {Function? onFinish}) async {
    isLoadingGetData.value = true;

    try{
      final resp = await dio.get("$urlGetDataVerify", queryParameters: {
        "user_id" : userId
      });
      checkLogin(resp);
      isLoadingGetData.value = false;

      try {
        GetVerifyDataResponse response = GetVerifyDataResponse.fromJson(resp.data);
        if(response.errors == null){
          if(onFinish !=null){
            onFinish(response);
          }
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: _.toString());
        errorToast(msg: "Terjadi kesalahan data");
      }
    }catch(_){
      isLoadingGetData.value = false;
      printLog(msg: "${_.toString()}");
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}