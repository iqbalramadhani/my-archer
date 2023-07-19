
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../core/models/objects/club_model.dart';
import '../../../core/models/objects/region_model.dart';
import '../../../core/models/response/club_response.dart';
import '../../../core/models/response/my_club_response.dart';
import '../../../core/models/response/region_response.dart';

class MyClubController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxString validationEmail = "".obs;
  RxString validationPass = "".obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingClub = false.obs;
  RxBool isLoadingProvince = false.obs;
  RxBool isLoadingCity = false.obs;

  RxInt currentPageMyClub = 1.obs;
  RxInt currentPageClub = 1.obs;
  RxInt currentPageProvince = 1.obs;
  RxInt currentPageCity = 1.obs;

  RxBool validLoadMoreClubs = false.obs;
  RxBool validLoadMoreMyClubs = false.obs;
  RxBool validLoadMoreCity = false.obs;
  RxBool validLoadMoreProvince = false.obs;

  Rx<RegionModel> selectedProvince = RegionModel().obs;
  Rx<RegionModel> selectedCity = RegionModel().obs;

  RxList<RegionModel> provinces = <RegionModel>[].obs;
  RxList<RegionModel> cities = <RegionModel>[].obs;

  RxList<RegionModel> filterProvinces = <RegionModel>[].obs;
  RxList<RegionModel> filterCities = <RegionModel>[].obs;

  RxList<ClubModel> clubs = <ClubModel>[].obs;
  RxList<DetailClubModel> myClubs = <DetailClubModel>[].obs;

  initController() async {
    apiGetMyClub();
    apiGetProvince();
  }

  refreshData(){
    myClubs.clear();
    currentPageMyClub.value = 1;
    validLoadMoreMyClubs.value = false;
    apiGetMyClub();
  }

  refreshDataClub(){
    clubs.clear();
    currentPageClub.value = 1;
    validLoadMoreClubs.value = false;
    apiGetClubs();
  }

  void apiGetMyClub() async {
    isLoading.value = true;

    try{
      Map<String, dynamic> param = {
        "limit" : 50,
        "page" : currentPageMyClub.value,
      };

      final resp = await dio.get("$urlMyClub", queryParameters: param);
      checkLogin(resp);
      isLoading.value = false;

      try {
        MyClubResponse response = MyClubResponse.fromJson(resp.data);
        if(response.errors == null){
          if(response.data!.isNotEmpty){
            for(var item in response.data!) {
              myClubs.add(item);
            }
            validLoadMoreMyClubs.value = true;
            currentPageMyClub.value +=1;
          }else{
            validLoadMoreMyClubs.value = false;
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
    }catch(e){
      isLoading.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${e.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetClubs({String? name}) async {
    isLoadingClub.value = true;

    Map<String, dynamic> param = {
      "limit" : 50,
      "page" : currentPageClub.value,
    };

    if(name != null)
      param["name"] = "$name";

    if(selectedProvince.value.id != null)
      param["province"] = "${selectedProvince.value.id}";

    if(selectedCity.value.id != null)
      param["city"] = "${selectedCity.value.id}";

    try{
      final resp = await dio.get("$urlClub", queryParameters: param);
      checkLogin(resp);
      isLoadingClub.value = false;

      try {
        ClubResponse response = ClubResponse.fromJson(resp.data);
        if(response.errors == null){
          if(response.data!.isNotEmpty){
            for(var item in response.data!) {
              clubs.add(item);
            }
            validLoadMoreClubs.value = true;
            currentPageClub.value +=1;
          }else{
            validLoadMoreClubs.value = false;
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
      isLoadingClub.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetProvince() async {
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
      isLoadingProvince.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetCity() async {
    isLoadingCity.value = true;

    try{

      Map<String, dynamic> param = {
        "limit" : 300,
        "page" : 1,
        "province_id" : selectedProvince.value.provinceId
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
