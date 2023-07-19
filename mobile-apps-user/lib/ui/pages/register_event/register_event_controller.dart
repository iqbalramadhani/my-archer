

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../core/models/objects/category_register_event_model.dart';
import '../../../core/models/objects/club_model.dart';
import '../../../core/models/objects/event_model.dart';
import '../../../core/models/objects/master_category_register_event_model.dart';
import '../../../core/models/objects/participant_model.dart';
import '../../../core/models/objects/profile_model.dart';
import '../../../core/models/objects/team_category_detail.dart';
import '../../../core/models/response/check_email_event_response.dart';

class RegisterEventController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  Rx<TextEditingController> categoryTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> namePendaftarTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> emailPendaftarTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> phonePendaftarTxtCtrl = TextEditingController().obs;

  Rx<TextEditingController> nameTeamTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> clubNameTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant1TxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant2TxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant3TxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant4TxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> participant5TxtCtrl = TextEditingController().obs;

  RxBool genderMixValid = true.obs;
  RxInt isWakilClub = 1.obs;

  // Rx<ProfileModel> selectedParticipant1 = ProfileModel().obs;
  Rx<ClubModel> selectedClub = ClubModel().obs;

  RxList<ParticipantModel> members = <ParticipantModel>[].obs;

  RxBool isLoading = false.obs;

  RxList<MasterCategoryRegisterEventModel> mastercategoryRegister = <MasterCategoryRegisterEventModel>[].obs;
  RxList<CategoryRegisterEventModel> allCategoryRegister = <CategoryRegisterEventModel>[].obs;

  RxInt selectedCategoryId = 0.obs;
  Rx<CategoryRegisterEventModel> selectedCategory = CategoryRegisterEventModel().obs;

  Rx<EventModel> currentData = EventModel().obs;

  RxBool sameWithRegistrant = false.obs;

  RxList<ProfileModel> participants = <ProfileModel>[].obs;

  Rx<ProfileModel> user = ProfileModel().obs;

  RxString type = STR_INDIVIDU.obs;

  initController() async {
    if(box.read(KEY_USER) != null){
      try {
        user.value = box.read(KEY_USER);
      } catch (_) {
        user.value = ProfileModel.fromJson(box.read(KEY_USER));
      }
    }

    namePendaftarTxtCtrl.value.text = user.value.name ?? "-";
    emailPendaftarTxtCtrl.value.text = user.value.email ?? "-";
    phonePendaftarTxtCtrl.value.text = user.value.phoneNumber ?? "-";

    injectParticipants();
    apiCategoryEventRegister();

    print("participants => ${participants.length}");

  }

  bool checkValidButton(){
    if(type.value == STR_INDIVIDU){
      if(participants[0].name != null){
        if(isWakilClub.value == 1 && selectedClub.value.detail == null){
          return false;
        }
        return true;
      }
    // }else if(type.value == STR_TIM){
    //   // if(selectedClub.value.detail != null && participants[0].name != null && participants[1].name != null && participants[2].name != null){
    //   if(selectedClub.value.detail != null && participants[0].name != null){
    //     return true;
    //   }
    }else{
      // if(selectedClub.value.detail != null && participants[0].name != null && participants[1].name != null && genderMixValid.value){
      if(selectedClub.value.detail != null && participants[0].name != null){
        return true;
      }
    }

    return false;
  }

  checkGenderMixTeam(){
    bool maleGender = participants.any((element) => element.gender == "male");
    bool femaleGender = participants.any((element) => element.gender == "female");

    genderMixValid.value =  maleGender && femaleGender;
  }

  bool isMinParticipantValid(int min){
    int participant = participants.where((p0) => p0.name != null).length;
    return participant >= min;
  }

  injectParticipants(){
    for(int i =0; i < 5; i++){
      participants.add(ProfileModel());
    }
  }

  setParticipant1(bool sameWithRegistrant){
    if(sameWithRegistrant){
      participants[0] = user.value;
      participant1TxtCtrl.value.text = user.value.name!;
    }else{
      participants[0] = ProfileModel();
      participant1TxtCtrl.value.text = "";
    }
  }

  void apiCheckEmailMember(String teamName, String email, String clubId, String categoryId, {Function? onFinish}) async {
    loadingDialog();

    mastercategoryRegister.clear();
    allCategoryRegister.clear();

    try{
      final resp = await dio.get("$urlCheckEmailMemberEvent", queryParameters: {
        "category_id" : categoryId,
        "club_id" : clubId,
        "team_name" : teamName,
        "email" : email
      });
      checkLogin(resp);
      Get.back();

      try {
        CheckEmailEventResponse response = CheckEmailEventResponse.fromJson(resp.data);
        if(response.errors == null){
          members.clear();
          if(response.data != null)
            members.addAll(response.data!);
          if(onFinish != null)
            onFinish();
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

  void apiCategoryEventRegister() async {
    loadingDialog();

    try{
      mastercategoryRegister.clear();
      allCategoryRegister.clear();

      Map<String, dynamic> param = {
        "event_id" : currentData.value.id,
      };

      final resp = await dio.get("$urlCategoryEventRegister", queryParameters: param);
      checkLogin(resp);
      Get.back();

      Map mapValue = resp.data;
      if(mapValue["data"] != null){
        getData(mapValue);
      }else if(mapValue["errors"] != null){
        errorToast(msg: getErrorMessage(resp));
      }else if(mapValue["message"] != null){
        errorToast(msg: "${mapValue["message"]}");
      }
    }catch(e){
      Get.back();
      printLog(msg: "error get category event");
      errorToast(msg: "Terjadi Kesalahan, harap ulangi kembali");
    }
  }

  getData(dynamic mapValue) {
    List<MasterCategoryRegisterEventModel> data = <MasterCategoryRegisterEventModel>[];
    mapValue['data'].forEach((key, value) {
      List<CategoryRegisterEventModel> categories = <CategoryRegisterEventModel>[];
      value.forEach((item) {
        categories.add(CategoryRegisterEventModel(
          id: item['id'],
          eventId: item['eventId'],
          ageCategoryId: item['ageCategoryId'],
          competitionCategoryId: item['competitionCategoryId'],
          distanceId: item['distanceId'],
          teamCategoryId: item['teamCategoryId'],
          quota: item['quota'],
          createdAt: item['createdAt'],
          updatedAt: item['updatedAt'],
          fee: item['fee'],
          earlyBird: item['earlyBird'],
          isEarlyBird: item['isEarlyBird'],
          isOpen: item['isOpen'],
          totalParticipant: item['totalParticipant'],
          categoryLabel: item['categoryLabel'],
          teamCategoryDetail: TeamCategoryDetail(
            id: item['teamCategoryDetail']['id'],
            label: item['teamCategoryDetail']['label']
          ),
        ));
      });
      data.add(MasterCategoryRegisterEventModel(name: key, datas: categories));
      allCategoryRegister.addAll(categories);
    });

    mastercategoryRegister.addAll(data);
    print("all category register size => ${allCategoryRegister.first.categoryLabel}");
    if(selectedCategoryId.value != 0){
      if(allCategoryRegister.any((p0) => p0.id == selectedCategoryId.value)) {
        selectedCategory.value = allCategoryRegister
            .where((p0) => p0.id == selectedCategoryId.value)
            .first;
        setSelectedCategory();
      }
    }else{
      if(allCategoryRegister.first.isOpen!) {
        selectedCategory.value = allCategoryRegister.first;
        setSelectedCategory();
      }
    }
  }

  setSelectedCategory(){
    categoryTxtCtrl.value.text = "${selectedCategory.value.teamCategoryDetail?.label!} - ${selectedCategory.value.categoryLabel!}";

    if(selectedCategory.value.teamCategoryDetail!.id!.toLowerCase().contains("individu")){
      printLog(msg: "individu");
      type.value = STR_INDIVIDU;
    }

    if(selectedCategory.value.teamCategoryDetail!.id!.toLowerCase().contains("team")){
      printLog(msg: "team");
      type.value = STR_TIM;
    }

    if(selectedCategory.value.teamCategoryDetail!.id!.toLowerCase().contains("mix")){
      printLog(msg: "mix");
      type.value = STR_MIX;
    }
  }



  @override
  void onClose() {
    super.onClose();
  }
}
