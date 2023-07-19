import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/event_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/event_pagination_response.dart';

class EventController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxBool isLoading = false.obs;
  Rx<ProfileModel> user = ProfileModel().obs;
  RxList<EventModel> events = <EventModel>[].obs;
  var searchTxtCtrl = TextEditingController().obs;

  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;

  reloadData(){
    currentPage.value = 1;
    totalPages.value = 1;
    events.clear();
    apiGetEventOrder();
  }

  initController(){
    if(box.read(KEY_USER) != null){
      try {
        user.value = box.read(KEY_USER);
      } catch (_) {
        user.value = ProfileModel.fromJson(box.read(KEY_USER));
      }
    }

    apiGetEventOrder();
  }

  void apiGetEventOrder() async {
    isLoading.value = true;

    try{
      final resp = await dio.get("$urlEvent", queryParameters: {
        "limit" : 20,
        "page" : currentPage.value,
        "event_name" : searchTxtCtrl.value.text
      });
      checkLogin(resp);
      isLoading.value = false;

      try {
        EventPaginationResponse response = EventPaginationResponse.fromJson(resp.data);
        if(response.data != null){
          totalPages.value = response.data!.totalPage!;
          if(currentPage.value == 1){
            events.addAll(response.data!.data!);
          }else{
            for(var item in response.data!.data!){
              events.add(item);
            }
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
      isLoading.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
      printLog(msg: "error get event");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}