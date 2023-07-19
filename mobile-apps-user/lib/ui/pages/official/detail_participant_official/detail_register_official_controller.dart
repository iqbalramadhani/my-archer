

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/models/response/base_response.dart';
import 'package:myarchery_archer/core/models/response/detail_official_response.dart';
import 'package:myarchery_archer/core/models/response/order_official_response.dart';
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
import '../../../../utils/strings.dart';
import '../../../shared/loading.dart';
import '../../../shared/modal_bottom.dart';
import '../../../shared/toast.dart';
import '../../profile/verify/verify_screen.dart';
import '../../transcation/list/list_transaction_screen.dart';
import '../../webview/webview_screen.dart';

class DetailRegisterOfficialController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  var currentData =  EventModel().obs;
  Rx<CategoryRegisterEventModel> selectedCategory = CategoryRegisterEventModel().obs;
  Rx<ClubModel> selectedClub = ClubModel().obs;
  Rx<ProfileModel> user = ProfileModel().obs;
  Rx<DataDetailOfficialModel> official = DataDetailOfficialModel().obs;

  RxBool isLoading = false.obs;

  initController() async {
    if(box.read(KEY_USER) != null){
      try {
        user.value = box.read(KEY_USER);
      } catch (_) {
        user.value = ProfileModel.fromJson(box.read(KEY_USER));
      }
    }
  }

  void apiOrderOfficial() async {
    loadingDialog();

    try{
      Map<String, dynamic> param = {
        "team_category_id" : selectedCategory.value.teamCategoryId,
        "age_category_id" : selectedCategory.value.ageCategoryId,
        "competition_category_id" : selectedCategory.value.competitionCategoryId,
        "distance_id" : selectedCategory.value.distanceId,
        "club_id" : selectedClub.value.detail!.id,
        "event_id" : currentData.value.id,
      };

      final resp = await dio.post("$urlOrderOfficial", data: param);
      checkLogin(resp);
      Get.back();

      try {
        OrderOfficialResponse response = OrderOfficialResponse.fromJson(resp.data);
        if(response.data != null){
          if(user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED || user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED || user.value.verifyStatus == KEY_VERIFY_ACC_SENT){
            modalBottomVerifyAccountHaveTransaction(content: str_unverified_acc_payment, skipable: false, onVerifyClicked: () async {
              goToPageWithResult(VerifyScreen(from: key_register_page,));
            }, onLater: (){
              goToPage(ListTransactionScreen(from: key_order_event_page,), dismissAllPage: true);
            });
          }else{
            goToPage(WebviewScreen(title: Translator.officialPayment.tr, url: "$urlMidtransSnap${response.data!.paymentInfo!.snapToken}", from: "order_event",));
          }
          // goToPage(ListTransactionScreen(from: key_order_event_page,), dismissAllPage: true);
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
      printLog(msg: "error get category event");
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
