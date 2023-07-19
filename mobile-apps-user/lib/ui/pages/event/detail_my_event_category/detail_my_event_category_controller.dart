
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/category_detail_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/base_response_data.dart';
import '../../../../core/models/response/detail_event_response.dart';
import '../../../../core/models/response/list_participant_myevent_response.dart';

class DetailMyEventCategoryController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();
  
  RxInt selectedMenu = 0.obs;
  RxBool isLoading = false.obs;

  Rx<CategoryDetailModel> category = CategoryDetailModel().obs;
  Rx<DataDetailEventModel> event = DataDetailEventModel().obs;

  Rx<TextEditingController> participant1TxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant2TxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant3TxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant4TxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant5TxtCtrl = TextEditingController().obs;

  RxList<ProfileModel> participants = <ProfileModel>[].obs;

  RxBool isEditMode = false.obs;

  Rx<ListParticipantMyEventResponse> membersResp = ListParticipantMyEventResponse().obs;

  initController() async {
    apiGetMembers();
  }

  void apiGetMembers() async {
    participants.clear();
    isLoading.value = true;

    try{
      final resp = await dio.get("$urlMemberMyEvent", queryParameters: {
        "participant_id" : category.value.detailParticipant!.idParticipant,
      });
      checkLogin(resp);
      isLoading.value = false;

      try {
        ListParticipantMyEventResponse response = ListParticipantMyEventResponse.fromJson(resp.data);
        if(response.data != null){
          membersResp.value = response;
            participants.add(response.data!.member!);

          if(participants.length > 0){
            participant1TxtCtrl.value.text = participants[0].name!;
          }

          if(participants.length > 1){
            participant2TxtCtrl.value.text = participants[1].name!;
          }

          if(participants.length > 2){
            participant3TxtCtrl.value.text = participants[2].name!;
          }

          if(participants.length > 3){
            participant4TxtCtrl.value.text = participants[3].name!;
          }

          if(participants.length > 4){
            participant5TxtCtrl.value.text = participants[4].name!;
          }

        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
        printLog(msg: "error get members => $_");
      }
    }catch(_){
      printLog(msg: "error get members => $_");
      isLoading.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiEditMember({Function? onFinish}) async {
    loadingDialog();

    try{
      Map<String, dynamic> param = {
        "participant_id" : "${membersResp.value.data!.participant!.participantId}",
        "club_id" : "${membersResp.value.data!.club!.first.id}",
        "team_name" : "${membersResp.value.data!.participant!.teamName}",
      };

      var list = <String>[];
      for(var item in participants){
        if(item.name!.isNotEmpty)
          list.add(item.id.toString());
      }
      param["user_id"] = list;

      final resp = await dio.post("$urlEditMemberMyEvent", data: param);
      checkLogin(resp);
      Get.back();

      try {
        BaseResponseData response = BaseResponseData.fromJson(resp.data);
        if(response.data != null){
          apiGetMembers();
          if(onFinish != null) onFinish();
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
      Get.back();
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
