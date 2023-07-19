import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/core/models/objects/option_distance_model.dart';
import 'package:myarcher_enterprise/core/models/responses/option_distance_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';

class OptionDistanceController extends GetxController {
  var box = GetStorage();
  var dio = ApiServices().launch();

  RxBool isLoading = false.obs;
  RxList<OptionDistanceModel> optionDistance = <OptionDistanceModel>[].obs;
  RxList<OptionDistanceModel> filterOptionDistance = <OptionDistanceModel>[].obs;

  void apiGetOptionDistance({bool? isClear, Function? onFinish}) async {
    if(isClear != null && isClear){
      optionDistance.clear();
      filterOptionDistance.clear();
    }

    isLoading.value = true;

    try{
      final resp = await dio.get(urlOptionDistance);
      isLoading.value = false;
      checkLogin(resp);

      try {
        OptionDistanceResponse response = OptionDistanceResponse.fromJson(resp.data);
        if(response.data != null){
          for(var item in response.data!){
            optionDistance.add(OptionDistanceModel(
              id: item.id,
              updatedAt: item.updatedAt,
              createdAt: item.createdAt,
              checked: false,
              eoId: item.eoId,
              distance: item.distance
            ));
          }
          filterOptionDistance.addAll(optionDistance);

          if(onFinish != null){
            onFinish();
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiGetOptionDistance(isClear: isClear, onFinish: onFinish);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiGetOptionDistance(isClear: isClear, onFinish: onFinish);
        });
      }
    }catch(_){
      isLoading.value = false;
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiGetOptionDistance(isClear: isClear, onFinish: onFinish);
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
