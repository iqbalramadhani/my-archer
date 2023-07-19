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
import 'package:path/path.dart' as p;

import '../../../../core/models/objects/event_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/base_response.dart';
import '../../../../core/models/response/profile_response.dart';

class EditProfileController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxString selectedGender = "L".obs;
  RxString selectedDateBirth = "".obs;

  RxString btnStatusVerify = "Verifikasi".obs;
  RxString contentStatusVerify = "Harap melakukan verifikasi data jika Anda akan mengikuti pertandingan.".obs;

  RxBool loadingProfile = false.obs;
  RxBool loadingEventOrder = false.obs;
  Rx<ProfileModel> user = ProfileModel().obs;
  RxList<EventModel> events = <EventModel>[].obs;
  RxBool isHeaderHide = false.obs;

  var nameTxtCtrl = TextEditingController().obs;
  var birthDateTxtCtrl = TextEditingController().obs;
  var phoneTxtCtrl = TextEditingController().obs;

  initController(){
    getCurrentData();
    apiProfile();
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
    if(user.value.gender != null) {
      selectedGender.value =
      user.value.gender!.toLowerCase() == "female" ? "P" : "L";
    }else{
      selectedGender.value = "L";
    }
    phoneTxtCtrl.value.text = user.value.phoneNumber ?? "";

    if(user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED){
      // statusVerify.value = "Belum Terverifikasi";
      contentStatusVerify.value = "Harap melakukan verifikasi data jika Anda akan mengikuti pertandingan.";
      btnStatusVerify.value = "Verifikasi";
    }else if(user.value.verifyStatus == KEY_VERIFY_ACC_SENT){
      // statusVerify.value = "Diajukan";
      contentStatusVerify.value = "Akun Anda dalam proses pengajuan. Silakan tunggu hingga proses verifikasi selesai.";
      btnStatusVerify.value = "Lihat Detail";
    }else if(user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED){
      // statusVerify.value = "Ditolak";
      contentStatusVerify.value = "Pengajuan ditolak. Silakan ajukan ulang verifikasi data Anda. Catatan: KTP Tidak jelas. Catatan : ${user.value.reasonRejected}";
      btnStatusVerify.value = "Ajukan Ulang";
    }else if(user.value.verifyStatus == KEY_VERIFY_ACC_VERIFIED){
      // statusVerify.value = "Terverifikasi";
      contentStatusVerify.value = "Akun Anda telah terverifikasi";
      btnStatusVerify.value = "";
    }
  }

  void apiProfile() async {
    loadingProfile.value = true;

    try{
      final resp = await dio.get("$urlProfile");
      checkLogin(resp);
      loadingProfile.value = false;

      try {
        ProfileResponse response = ProfileResponse.fromJson(resp.data);
        if(response.data != null){
          box.write(KEY_USER, response.data!);
          user.value = response.data!;
          getCurrentData();
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
      loadingProfile.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiUpdateProfile() async {
    loadingDialog();

    try{
      final resp = await dio.put("$urlUpdateProfile", queryParameters: {
        "user_id" : user.value.id
      }, data: {
        "date_of_birth" : selectedDateBirth.value,
        "gender" : selectedGender.value == "L" ? "male" : "female",
        "name" : nameTxtCtrl.value.text.toString(),
        "phone_number" : phoneTxtCtrl.value.text.toString(),
      });
      checkLogin(resp);
      Get.back();

      try {
        ProfileResponse response = ProfileResponse.fromJson(resp.data);
        if(response.data != null){
          box.write(KEY_USER, response.data!);
          user.value = response.data!;
          getCurrentData();
          Navigator.pop(Get.context!, true);
          successToast(msg: "Berhasil memperbarui Data");
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

  void apiUpdateAvatar({required File avatar, required String idUser}) async {
    ///validation format
    final extension = p.extension(avatar.path);
    printLog(msg: "extension file => $extension");
    if(extension.toLowerCase() != ".jpeg" && extension.toLowerCase() != ".jpg" && extension.toLowerCase() != ".png"){
      errorToast(msg: "Format file tidak didukung, harap gunakan format JPG, JPEG atau PNG");
      return;
    }

    ///validation size photo
    if(avatar.lengthSync() > 500000){
      errorToast(msg: "Ukuran file maksimal adalah 500kb. Ukuran File Foto yang anda pilih adalah ${avatar.lengthSync()/1000}kb");
      return;
    }


    loadingDialog();
    try{

      Map<String, dynamic> param = {
        "avatar" : convertImagetoBase64(avatar),
      };

      final resp = await dio.put("$urlUpdateAvatar", queryParameters: {
        "user_id" : idUser
      }, data: param);
      checkLogin(resp);
      Get.back();

      try {
        BaseResponse response = BaseResponse.fromJson(resp.data);
        if(response.errors == null){
          successToast(msg: "Berhasil memperbarui Foto Profil");
          apiProfile();
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
      printLog(msg: "error post club => $_");
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