
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/category_detail_model.dart';
import '../../../../core/models/objects/team_category_detail.dart';
import '../../../../core/models/response/detail_event_response.dart';
import '../../../../core/models/response/detail_my_event_response.dart';

class DetailMyEventController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxList<CategoryDetailModel> datas = <CategoryDetailModel>[].obs;
  Rx<DataDetailEventModel> eventDetail = DataDetailEventModel().obs;
  RxList<TeamCategoryDetail> statusPayments = <TeamCategoryDetail>[].obs;
  Rx<TeamCategoryDetail> selectedStatus = TeamCategoryDetail().obs;
  RxInt idEvent = 0.obs;

  RxBool isLoading = false.obs;

  initController() async {
    apiGetDetailEvent();
  }

  injectStatus(){
    statusPayments.add(TeamCategoryDetail(id: 0, label: Translator.all.tr));
    statusPayments.add(TeamCategoryDetail(id: 4, label: Translator.payment.tr));
    statusPayments.add(TeamCategoryDetail(id: 2, label: Translator.qualification.tr));
    statusPayments.add(TeamCategoryDetail(id: 1, label: Translator.elimination.tr));

    selectedStatus.value = statusPayments.first;
  }

  void apiGetDetailEvent() async {
    isLoading.value = true;

    try{
      final resp = await dio.get("$urlDetailMyEvent", queryParameters: {
        "event_id" : idEvent.value,
      });
      checkLogin(resp);
      isLoading.value = false;

      try {
        DetailMyEventResponse response = DetailMyEventResponse.fromJson(resp.data);
        if(response.data != null){
          eventDetail.value = response.data!.eventDetail!;
          datas.addAll(response.data!.categoryDetail!);
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
        debugPrint("error get detail event => $_");
      }
    }catch(e){
      isLoading.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${e.toString()}" : Translator.somethingWentWrong.tr;
      printLog(msg: "error get detail event => $e");
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
