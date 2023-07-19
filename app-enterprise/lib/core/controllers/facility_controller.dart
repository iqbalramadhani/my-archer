import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/core/models/responses/facility_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';

class FacilityController extends GetxController {
  var box = GetStorage();
  var dio = ApiServices().launch();

  RxBool isLoading = false.obs;
  RxList<FacilityModel> otherFacilities = <FacilityModel>[].obs;
  RxList<FacilityModel> filterOtherFacilities = <FacilityModel>[].obs;

  void apiGetOtherFacility({bool? isClear}) async {
    if(isClear != null && isClear){
      otherFacilities.clear();
      filterOtherFacilities.clear();
    }

    isLoading.value = true;

    try{
      final resp = await dio.get(urlHistoryOtherFacilities);
      isLoading.value = false;
      checkLogin(resp);

      try {
        FacilityResponse response = FacilityResponse.fromJson(resp.data);
        if(response.data != null){
          for(var item in response.data!){
            if(item.isHide == 0){
              otherFacilities.add(FacilityModel(
                  id: item.id,
                  name: item.name,
                  eoId: item.eoId,
                  icon: item.icon,
                  createdAt: item.createdAt,
                  updatedAt: item.updatedAt,
                  checked: false
              ));
            }
          }

          filterOtherFacilities.addAll(otherFacilities);
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiGetOtherFacility();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiGetOtherFacility();
        });
      }
    }catch(_){
      isLoading.value = false;
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiGetOtherFacility();
      });
    }
  }

  void apiHideItemOtherFacility({required int id, Function? onFinish}) async {
    isLoading.value = true;

    try{
      final resp = await dio.post(urlHideHistoryOtherFacilities, queryParameters: {
        "id" : id
      }, data : {
        "is_hide" : true
      });
      isLoading.value = false;
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
          apiGetOtherFacility(isClear: true);
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiHideItemOtherFacility(id: id);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiHideItemOtherFacility(id: id);
        });
      }
    }catch(_){
      isLoading.value = false;
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiHideItemOtherFacility(id: id);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
