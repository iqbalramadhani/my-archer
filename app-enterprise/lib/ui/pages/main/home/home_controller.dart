

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/core/models/objects/profile_model.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/core/models/responses/base_response.dart';
import 'package:myarcher_enterprise/core/models/responses/venue_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';

class HomeController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  ///trigger loading
  RxBool isLoading = false.obs;

  Rx<ProfileModel> user = ProfileModel().obs;
  RxList<VenueModel> venues = <VenueModel>[].obs;

  initController() async {
    apiGetListVenue();
    getCurrentUser();
  }

  getCurrentUser(){
    user.value = GlobalHelper().getCurrentUser();
  }

  void apiGetListVenue({bool? isClear}) async {
    if(isClear != null && isClear){
      venues.clear();
    }

    isLoading.value = true;

    try{
      final resp = await dio.get(urlListVenue, queryParameters: {
        "limit" : 100,
        "page" : 1
      });
      isLoading.value= false;
      checkLogin(resp);

      try {
        VenueResponse response = VenueResponse.fromJson(resp.data);
        if(response.data != null){
          for(var item in response.data!){
            venues.add(item);
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiGetListVenue();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiGetListVenue();
        });
      }
    }catch(_){
      isLoading.value= false;
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiGetListVenue();
      });
    }
  }

  void apiDeleteDraft({required int id}) async {
    loadingDialog();

    try{
      final resp = await dio.post(urlDeleteVenue, queryParameters: {
        "id" : id,
      });
      Get.back();
      checkLogin(resp);

      try {
        BaseResponse response = BaseResponse.fromJson(resp.data);
        if(resp.statusCode.toString().startsWith("2")){
          Toast().successToast(msg: response.message);
          apiGetListVenue(isClear: true);
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiDeleteDraft(id: id);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiDeleteDraft(id: id);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiDeleteDraft(id: id);
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
