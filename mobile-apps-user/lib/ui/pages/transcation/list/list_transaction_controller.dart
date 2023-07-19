import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/models/response/v2/order_all_response.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/objects/team_category_detail.dart';

class ListTransactionController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxList<TeamCategoryDetail> statusPayments = <TeamCategoryDetail>[].obs;

  Rx<TeamCategoryDetail> selectedStatus = TeamCategoryDetail().obs;

  Rx<ProfileModel> user = ProfileModel().obs;
  RxBool isLoading = false.obs;
  // RxList<DataModel> orders = <DataModel>[].obs;
  RxList<DataOrderAllModel> orders = <DataOrderAllModel>[].obs;

  initController() async {
    getCurrentUser();
    injectStatus();
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

  injectStatus() {
    statusPayments.add(TeamCategoryDetail(id: 0, label: "Semua"));
    statusPayments.add(TeamCategoryDetail(id: 4, label: "Menunggu Pembayaran"));
    statusPayments.add(TeamCategoryDetail(id: 2, label: "Kadaluarsa"));
    statusPayments.add(TeamCategoryDetail(id: 1, label: "Berhasil"));
    // statusPayments.add(TeamCategoryDetail(id: 3, label: "Gagal"));

    selectedStatus.value = statusPayments.first;
  }

  // void apiGetListOrder({Function? onFinish}) async {
  //   isLoading.value = true;

  //   try {
  //     final resp;
  //     if (selectedStatus.value.id == 0) {
  //       resp = await dio.get("$urlEventOrder");
  //     } else {
  //       var status = "";
  //       if (selectedStatus.value.id == 4) {
  //         status = "pending";
  //       } else if (selectedStatus.value.id == 2) {
  //         status = "expired";
  //       } else if (selectedStatus.value.id == 1) {
  //         status = "success";
  //       }

  //       resp = await dio.get("$urlEventOrder", queryParameters: {
  //         "status": status,
  //       });
  //     }

  //     isLoading.value = false;

  //     try {
  //       EventOrderResponse response = EventOrderResponse.fromJson(resp.data);
  //       if (response.data != null) {
  //         orders.addAll(response.data!);
  //         if (onFinish != null) onFinish(response);
  //       } else if (response.errors != null) {
  //         errorToast(msg: getErrorMessage(resp));
  //       } else if (response.message != null) {
  //         errorToast(msg: "${response.message}");
  //       }
  //     } catch (_) {
  //       printLog(msg: "error get list event order ${_.toString()}");
  //       errorToast(msg: "Terjadi kesalahan");
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     printLog(msg: "error get list event order ${e.toString()}");
  //     errorToast(msg: "Terjadi kesalahan");
  //   }
  // }

  void apiGetListOrderV2({Function? onFinish}) async {
    isLoading.value = true;

    try {
      final resp;
      if(selectedStatus.value.id == 0){
        resp = await dio.get("$urlListOrderV2");
      }else{
        var status = "";
        if(selectedStatus.value.id == 4){
          status = "pending";
        }else if(selectedStatus.value.id == 2){
          status = "expired";
        }else if(selectedStatus.value.id == 1){
          status = "success";
        }

        resp = await dio.get("$urlListOrderV2", queryParameters: {
          "status" : status,
        });
      }

      checkLogin(resp);

      isLoading.value = false;

      try {
        OrderAllResponse response = OrderAllResponse.fromJson(resp.data);
        if (response.data != null) {
          orders.addAll(response.data!);
          if (onFinish != null) onFinish(response);
        } else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: "error get list event order v2 ${_.toString()}");
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    } catch (_) {
      isLoading.value = false;
      printLog(msg: "error get list event order v2 ${_.toString()}");
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
