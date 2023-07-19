

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';
import '../../../../core/models/objects/category_register_event_model.dart';
import '../../../../core/models/objects/club_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/order_event_response.dart';
import '../../../../utils/strings.dart';
import '../../../shared/modal_bottom.dart';
import '../../profile/verify/verify_screen.dart';
import '../../transcation/list/list_transaction_screen.dart';
import '../../webview/webview_screen.dart';

class ReviewParticipantController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxList<ProfileModel> participants = <ProfileModel>[].obs;
  Rx<ClubModel> selectedClub = ClubModel().obs;
  Rx<CategoryRegisterEventModel> selectedCategory = CategoryRegisterEventModel().obs;

  Rx<ProfileModel> user = ProfileModel().obs;

  RxString type = STR_INDIVIDU.obs;
  RxString teamName = "".obs;

  initController() async {
    if(box.read(KEY_USER) != null){
      try {
        user.value = box.read(KEY_USER);
      } catch (_) {
        user.value = ProfileModel.fromJson(box.read(KEY_USER));
      }
    }
  }

  void apiOrderEvent() async {
    loadingDialog();

    Map<String, dynamic> param = {
      "event_category_id" : selectedCategory.value.id,
      "club_id" : selectedClub.value.detail == null ?  0 : selectedClub.value.detail!.id,
      "withClub" : selectedClub.value.detail == null ? "no" : "yes"
    };


    if(type.value == STR_TIM || type.value == STR_MIX){
      param["team_name"] = teamName.value;
      var list = <String>[];
      for(var item in participants){
        list.add(item.id.toString());
      }
      param["user_id"] = list;
    }

    try{
      final resp = await dio.post("$urlEventOrder", data: param);
      checkLogin(resp);
      Get.back();

      try {
        OrderEventResponse response = OrderEventResponse.fromJson(resp.data);
        if(response.data != null){
          if(user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED || user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED || user.value.verifyStatus == KEY_VERIFY_ACC_SENT){
            modalBottomVerifyAccountHaveTransaction(content: str_unverified_acc_payment, skipable: false, onVerifyClicked: () async {
              goToPageWithResult(VerifyScreen(from: key_register_page,));
            }, onLater: (){
              goToPage(ListTransactionScreen(from: key_order_event_page,), dismissAllPage: true);
            });
          }else{
            goToPage(WebviewScreen(title: "Pembayaran Event", url: "$urlMidtransSnap${response.data!.paymentInfo!.snapToken}", from: "order_event",));
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
