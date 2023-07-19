import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/models/objects/transaction_info_model.dart';
import 'package:myarchery_archer/core/models/response/v2/detail_order_official_response.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/detail_event_order_response.dart';
import '../../../../core/models/response/v2/order_all_response.dart';

class DetailEventOrderController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  Rx<ProfileModel> user = ProfileModel().obs;
  RxBool isLoading = false.obs;
  RxBool isExpired = false.obs;

  Rx<DetailOrderModel> paramOrder = DetailOrderModel().obs;
  Rx<DetailEventOrderResponse> currentResp = DetailEventOrderResponse().obs;
  Rx<DetailOrderOfficialResponse> currentRespOfficial = DetailOrderOfficialResponse().obs;

  RxBool dataNotFound = true.obs;

  RxString dateOrder = "".obs;
  RxString orderId = "".obs;
  RxString eventName = "".obs;
  RxString eventPoster = "".obs;
  RxString location = "".obs;
  RxString jenisRegu = "".obs;
  RxString category = "".obs;
  RxString clubName = "".obs;
  Rx<TransactionInfoModel> transactionLog = TransactionInfoModel().obs;


  initController() async {
    getCurrentUser();
    if (paramOrder.value.type == "official") {
      apiGetDetailOrderOfficial();
    } else {
      apiGetDetailOrder();
    }
  }

  getCurrentUser() {
    if (box.read(KEY_USER) != null) {
      try {
        user.value = box.read(KEY_USER);
      } catch (_) {
        user.value = ProfileModel.fromJson(box.read(KEY_USER));
      }
    }
  }

  setData(dynamic response){
    if(response is DetailEventOrderResponse){
      DetailEventOrderResponse respData = response;
      dateOrder.value = respData.data!.participant!.createdAt!;
      orderId.value = respData.data!.transactionInfo!.orderId ?? "";
      eventName.value = respData.data!.archeryEvent!.eventName ?? "";
      eventPoster.value = respData.data!.archeryEvent!.poster ?? "";
      location.value = "${respData.data!.archeryEvent!.location} - ${respData.data!.archeryEvent!.locationType}";
      jenisRegu.value =  respData.data!.participant!.teamCategoryId!;
      category.value =  respData.data!.participant!.categoryLabel!;
      clubName.value =  (respData.data!.participant!.clubDetail == null) ? "-" : "${respData.data!.participant!.clubDetail!.name}";
      transactionLog.value =  respData.data!.transactionInfo!;
    }else{
      DetailOrderOfficialResponse respData = response;
      dateOrder.value = respData.data!.transactionInfo!.orderDate!.date!.split(".").first;
      orderId.value = respData.data!.transactionInfo!.orderId ?? "";
      eventName.value = respData.data!.eventOfficialDetail!.detailEvent!.publicInformation!.eventName ?? "";
      eventPoster.value = respData.data!.eventOfficialDetail!.detailEvent!.publicInformation!.eventBanner ?? "";
      location.value = "${respData.data!.eventOfficialDetail!.detailEvent!.publicInformation!.eventLocation} - ${respData.data!.eventOfficialDetail!.detailEvent!.publicInformation!.eventLocationType}";
      jenisRegu.value =  convertTeamCategory("${respData.data!.detailEventOfficial!.teamCategoryId}");
      category.value =  "${respData.data!.detailEventOfficial!.categoryLabel}";
      clubName.value =  (respData.data!.clubDetail == null) ? "-" : "${respData.data!.clubDetail!.name}";
      transactionLog.value =  respData.data!.transactionInfo!;
    }
  }

  void apiGetDetailOrder() async {
    isLoading.value = true;

    try {
      Map<String, dynamic> param = {
        "id": "${paramOrder.value.id}"
      };

      final resp = await dio.get("$urlDetailEventOrder", queryParameters: param);
      checkLogin(resp);
      isLoading.value = false;

      try {
        DetailEventOrderResponse response = DetailEventOrderResponse.fromJson(resp.data);
        if (response.errors == null) {
          currentResp.value = response;
          if(response.data != null){
            dataNotFound.value = false;
            setData(response);
          }
        } else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    } catch (_) {
      printLog(msg: "error get my club => $_");
      isLoading.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetDetailOrderOfficial() async {
    isLoading.value = true;

    try {
      Map<String, dynamic> param = {
        "event_official_id": "${paramOrder.value.id}"
      };

      final resp = await dio.get("$urlDetailOrderOfficial", queryParameters: param);
      checkLogin(resp);
      isLoading.value = false;

      try {
        DetailOrderOfficialResponse response = DetailOrderOfficialResponse.fromJson(resp.data);
        if (response.errors == null) {
          currentRespOfficial.value = response;
          if(response.data != null){
            dataNotFound.value = false;
            setData(response);
          }
        } else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: "error get detail order official => $_");
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    } catch (_) {
      printLog(msg: "error get detail order official => $_");
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
