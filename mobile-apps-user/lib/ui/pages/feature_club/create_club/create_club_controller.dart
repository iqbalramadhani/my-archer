
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/club_model.dart';
import '../../../../core/models/objects/region_model.dart';
import '../../../../core/models/response/base_response.dart';
import '../../../../core/models/response/detail_club_response.dart';
import '../../../../core/models/response/region_response.dart';

class CreateClubController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  Rx<XFile> selectedBanner = XFile("").obs;
  Rx<XFile> selectedLogo = XFile("").obs;

  RxBool isSuccess = false.obs;

  Rx<TextEditingController> nameClubTxtController = TextEditingController().obs;
  Rx<TextEditingController> namePlaceTxtController = TextEditingController().obs;
  Rx<TextEditingController> addressTxtController = TextEditingController().obs;
  Rx<TextEditingController> provinceTxtController = TextEditingController().obs;
  Rx<TextEditingController> cityTxtController = TextEditingController().obs;
  Rx<TextEditingController> descTxtController = TextEditingController().obs;
  Rx<FocusNode> alamatLatihanFocus = FocusNode().obs;

  RxBool isLoadingProvince = false.obs;
  RxBool isLoadingCity = false.obs;

  RxInt currentPageProvince = 1.obs;
  RxInt currentPageCity = 1.obs;

  RxBool validLoadMoreCity = false.obs;
  RxBool validLoadMoreProvince = false.obs;

  Rx<RegionModel> selectedProvince = RegionModel().obs;
  Rx<RegionModel> selectedCity = RegionModel().obs;

  RxList<RegionModel> provinces = <RegionModel>[].obs;
  RxList<RegionModel> cities = <RegionModel>[].obs;

  RxList<RegionModel> filterProvinces = <RegionModel>[].obs;
  RxList<RegionModel> filterCities = <RegionModel>[].obs;

  Rx<DetailClubModel> dataDetail = DetailClubModel().obs;

  RxString errorNameClub = "".obs;
  RxString errorTempatLatihan = "".obs;
  RxString errorAddress = "".obs;
  RxString errorProvince = "".obs;
  RxString errorCity = "".obs;
  RxString errorDesc = "".obs;

  RxString currentLogo = "".obs;
  RxString currentBanner = "".obs;

  Rx<DetailClubModel> currentData = DetailClubModel().obs;

  initController(){
    if(currentData.value.name != null){
      nameClubTxtController.value.text = currentData.value.name!;
      namePlaceTxtController.value.text = currentData.value.placeName!;
      addressTxtController.value.text = currentData.value.address!;
      provinceTxtController.value.text = currentData.value.detailProvince!.name!;
      cityTxtController.value.text = currentData.value.detailCity!.name!;
      descTxtController.value.text = currentData.value.description!;

      selectedProvince.value = currentData.value.detailProvince!;
      selectedCity.value = currentData.value.detailCity!;

      currentLogo.value = currentData.value.logo ?? "";
      currentBanner.value = currentData.value.banner ?? "";
    }
  }

  void apiGetProvince() async {
    isLoadingProvince.value = true;

    Map<String, dynamic> param = {
      "limit" : 50,
      "page" : currentPageProvince.value,
    };

    try{
      final resp = await dio.get("$urlProvince", queryParameters: param);
      checkLogin(resp);
      isLoadingProvince.value = false;

      try {
        RegionResponse response = RegionResponse.fromJson(resp.data);
        if(response.errors == null){
          if(response.data!.isNotEmpty){
            filterProvinces.clear();
            for(var item in response.data!) {
              provinces.add(item);
            }
            validLoadMoreProvince.value = true;
            currentPageProvince.value +=1;

            filterProvinces.addAll(provinces);
          }else{
            validLoadMoreProvince.value = false;
          }
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
      printLog(msg: "error get province => $_");
      isLoadingProvince.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetCity(String provinceId) async {
    isLoadingCity.value = true;

    try{

      Map<String, dynamic> param = {
        "limit" : 300,
        "page" : 1,
        "province_id" : provinceId
      };

      final resp = await dio.get("$urlCity", queryParameters: param);
      checkLogin(resp);
      isLoadingCity.value = false;

      try {
        RegionResponse response = RegionResponse.fromJson(resp.data);
        if(response.errors == null){
          if(response.data!.isNotEmpty){
            filterCities.clear();
            for(var item in response.data!) {
              cities.add(item);
            }
            currentPageCity.value +=1;
            validLoadMoreCity.value = true;
            filterCities.addAll(cities);
          }else{
            validLoadMoreCity.value = false;
          }
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
      printLog(msg: "error get city => $_");
      isLoadingCity.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiCreateClub() async {
    loadingDialog();
    try{

      Map<String, dynamic> param = {
        "name" : nameClubTxtController.value.text,
        "place_name" : namePlaceTxtController.value.text,
        "province" : selectedProvince.value.id,
        "city" : selectedCity.value.id,
        "address" : addressTxtController.value.text,
        "description" : descTxtController.value.text,
      };

      if(selectedBanner.value.path != ""){
        param["banner"] = selectedBanner.value.path == "" ? "" : convertImagetoBase64(File("${selectedBanner.value.path}"));
      }

      if(selectedLogo.value.path != ""){
        param["logo"] = selectedLogo.value.path == "" ? "" : convertImagetoBase64(File("${selectedLogo.value.path}"));
      }

      final resp = await dio.post("$urlCreateClub", data: param);
      checkLogin(resp);
      Get.back();

      try {
        DetailClubResponse response = DetailClubResponse.fromJson(resp.data);
        if(response.errors == null){
          isSuccess.value = true;
          dataDetail.value = response.data!;
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
      debugPrint("error post club => $_");
      Get.back();
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiUpdateClub() async {
    loadingDialog();
    try{

      Map<String, dynamic> param = {
        "name" : nameClubTxtController.value.text,
        "place_name" : namePlaceTxtController.value.text,
        "province" : selectedProvince.value.id,
        "city" : selectedCity.value.id,
        "address" : addressTxtController.value.text,
        "description" : descTxtController.value.text,
      };

      if(selectedBanner.value.path != ""){
        param["banner"] = selectedBanner.value.path == "" ? "" : convertImagetoBase64(File("${selectedBanner.value.path}"));
      }

      if(selectedLogo.value.path != ""){
        param["logo"] = selectedLogo.value.path == "" ? "" : convertImagetoBase64(File("${selectedLogo.value.path}"));
      }

      Map<String, dynamic> paramUrl = {
        "id" : currentData.value.id
      };

      final resp = await dio.put("$urlUpdateClub", data: param, queryParameters: paramUrl);
      checkLogin(resp);
      Get.back();

      try {
        BaseResponse response = BaseResponse.fromJson(resp.data);
        if(response.errors == null){
          Navigator.pop(Get.context!, true);
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
      printLog(msg: "error update club => $_");
      Get.back();
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  createClub(){
    if(nameClubTxtController.value.text.isEmpty){
      errorNameClub.value = "Nama Klub tidak boleh kosong";
    }else{
      errorNameClub.value = "";
    }

    if(namePlaceTxtController.value.text.isEmpty){
      errorTempatLatihan.value = "Nama Tempat Latihan tidak boleh kosong";
    }else{
      errorTempatLatihan.value = "";
    }

    if(addressTxtController.value.text.isEmpty){
      errorAddress.value = "Alamat Tempat Latihan tidak boleh kosong";
    }else{
      errorAddress.value = "";
    }

    if(provinceTxtController.value.text.isEmpty){
      errorProvince.value = "Provinsi tidak boleh kosong";
    }else{
      errorProvince.value = "";
    }

    if(cityTxtController.value.text.isEmpty){
      errorCity.value = "Kota tidak boleh kosong";
    }else{
      errorCity.value = "";
    }

    if(nameClubTxtController.value.text.isEmpty || namePlaceTxtController.value.text.isEmpty || addressTxtController.value.text.isEmpty
    || provinceTxtController.value.text.isEmpty || cityTxtController.value.text.isEmpty){
      return;
    }

    if(currentData.value.name == null) {
      apiCreateClub();
    }else apiUpdateClub();

  }

  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
