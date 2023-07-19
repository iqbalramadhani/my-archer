

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/category_register_event_model.dart';
import '../../../../core/models/objects/club_model.dart';
import '../../../../core/models/objects/event_model.dart';
import '../../../../core/models/objects/master_category_register_event_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/objects/team_category_detail.dart';
import '../../../../utils/endpoint.dart';
import '../../../../utils/global_helper.dart';
import '../../../shared/loading.dart';
import '../../../shared/toast.dart';

class RegisterOfficialController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  var currentData =  EventModel().obs;

  Rx<TextEditingController> namePendaftarTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> emailPendaftarTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> phonePendaftarTxtCtrl = TextEditingController().obs;

  Rx<TextEditingController> categoryFirstTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> categoryTxtCtrl = TextEditingController().obs;
  Rx<TextEditingController> clubNameTxtCtrl = TextEditingController().obs;

  var errorClubMsg = "".obs;
  var errorCategoryMsg = "".obs;

  RxList<MasterCategoryRegisterEventModel> mastercategoryRegister = <MasterCategoryRegisterEventModel>[].obs;
  RxList<CategoryRegisterEventModel> allCategoryRegister = <CategoryRegisterEventModel>[].obs;

  RxInt selectedCategoryId = 0.obs;
  Rx<CategoryRegisterEventModel> selectedCategory = CategoryRegisterEventModel().obs;

  Rx<ClubModel> selectedClub = ClubModel().obs;
  Rx<ProfileModel> user = ProfileModel().obs;

  RxBool isLoading = false.obs;

  initController() async {
    if(box.read(KEY_USER) != null){
      try {
        user.value = box.read(KEY_USER);
      } catch (_) {
        user.value = ProfileModel.fromJson(box.read(KEY_USER));
      }
    }

    categoryFirstTxtCtrl.value.text = "Official";

    namePendaftarTxtCtrl.value.text = user.value.name ?? "-";
    emailPendaftarTxtCtrl.value.text = user.value.email ?? "-";
    phonePendaftarTxtCtrl.value.text = user.value.phoneNumber ?? "-";

    apiCategoryEventRegister();
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
    }catch(_){
      Get.back();
      printLog(msg: "error get category event");
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
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
  }

  bool checkValidButton(){
    if(selectedClub.value.detail == null || selectedCategory.value.id == null){
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
