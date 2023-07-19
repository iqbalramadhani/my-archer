
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/core/models/objects/region_model.dart';
import 'package:myarcher_enterprise/core/models/responses/region_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';

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
      final resp = await dio.get(urlProvince, queryParameters: param);
      isLoadingProvince.value = false;
      checkLogin(resp);

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
          Toast().errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          Toast().errorToast(msg: "${response.message}");
        }
      } catch (_) {
        Toast().errorToast(msg: _.toString());
      }
    }catch(e){
      printLog(msg: "error get province => $e");
      isLoadingProvince.value = false;
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

      final resp = await dio.get(urlCity, queryParameters: param);
      isLoadingCity.value = false;
      checkLogin(resp);

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
          Toast().errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          Toast().errorToast(msg: "${response.message}");
        }
      } catch (_) {
        Toast().errorToast(msg: _.toString());
      }
    }catch(e){
      printLog(msg: "error get city => $e");
      isLoadingCity.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
