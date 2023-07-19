
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/team_category_detail.dart';
import '../../../../core/models/response/detail_event_response.dart';
import '../../../../core/models/response/list_myevent_response.dart';

class MyEventController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxList<DataDetailEventModel> myEvents = <DataDetailEventModel>[].obs;
  RxList<TeamCategoryDetail> statusPayments = <TeamCategoryDetail>[].obs;
  Rx<TeamCategoryDetail> selectedStatus = TeamCategoryDetail().obs;

  RxBool isLoading = false.obs;

  initController() async {
    apiGetMyEvents();
  }

  injectStatus(){
    statusPayments.add(TeamCategoryDetail(id: 0, label: "Semua"));
    statusPayments.add(TeamCategoryDetail(id: 4, label: "Menunggu Pembayaran"));
    statusPayments.add(TeamCategoryDetail(id: 2, label: "Kadaluarsa"));
    statusPayments.add(TeamCategoryDetail(id: 1, label: "Berhasil"));
    // statusPayments.add(TeamCategoryDetail(id: 3, label: "Gagal"));

    selectedStatus.value = statusPayments.first;
  }

  void apiGetMyEvents() async {
    isLoading.value = true;

    try{
      final resp = await dio.get("$urlMyEvent");
      checkLogin(resp);
      isLoading.value = false;

      try {
        ListMyeventResponse response = ListMyeventResponse.fromJson(resp.data);
        if(response.data != null){
          myEvents.addAll(response.data!);
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
      printLog(msg: "error get my club => $_");
      isLoading.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
