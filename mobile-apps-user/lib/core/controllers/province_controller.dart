
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../models/objects/region_model.dart';
import '../models/response/region_response.dart';

class ProvinceController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();
  
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
  
  initController() async {
    apiGetProvince();
  }
  
  void apiGetProvince({Function? onFinish}) async {
    isLoadingProvince.value = true;

    Map<String, dynamic> param = {
      "limit" : 50,
      "page" : currentPageProvince.value,
    };

    param["name"] = "";

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

  void apiGetCity(String idProvince) async {
    isLoadingCity.value = true;

    try{

      Map<String, dynamic> param = {
        "limit" : 300,
        "page" : 1,
        "province_id" : idProvince
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

  @override
  void onClose() {
    super.onClose();
  }
}
