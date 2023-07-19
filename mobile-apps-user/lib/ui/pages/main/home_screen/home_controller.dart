import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/models/response/v2/order_all_response.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/event_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/event_pagination_response.dart';
import '../../../../core/models/response/list_myevent_response.dart';
import '../../../../core/models/response/profile_response.dart';
import '../../login/login_screen.dart';
import '../../profile/verify/verify_screen.dart';
import '../../transcation/list/list_transaction_controller.dart';

class HomeController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxBool loadingProfile = false.obs;
  RxBool loadingEventOrder = false.obs;
  Rx<ProfileModel> user = ProfileModel().obs;
  RxList<EventModel> events = <EventModel>[].obs;
  RxBool isHeaderHide = false.obs;

  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;

  RxInt totalTransactionSuccess = 0.obs;

  ListTransactionController transController = ListTransactionController();

  initController() {
    events.clear();
    apiProfile();

    apiGetEventOrder();
  }

  getCurrentUser() {
    try {
      user.value = box.read(KEY_USER);
    } catch (_) {
      user.value = ProfileModel.fromJson(box.read(KEY_USER));
    }

    transController.apiGetListOrderV2(onFinish: (OrderAllResponse resp) {
      if (user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED) {
        if (resp.data!.isNotEmpty) {
          modalBottomVerifyAccountHaveTransaction(onVerifyClicked: () async {
            Get.back();
            final result = await goToPageWithResult(VerifyScreen());
            if (result != null) initController();
          });
        } else {
          modalBottomVerifyAccount(
              skipable: true,
              onVerifyClicked: () async {
                Get.back();
                final result = await goToPageWithResult(VerifyScreen());
                if (result != null) initController();
              });
        }
      }
    });
    // apiGetMyEvents(onFinish: (){
    //   if(user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED){
    //     modalBottomVerifyAccount(skipable: totalTransactionSuccess.value == 0, onVerifyClicked: () async {
    //       Get.back();
    //       if(totalTransactionSuccess.value == 0) Get.back();
    //       final result = await goToPageWithResult(VerifyScreen());
    //       if(result != null) initController();
    //     });
    //   }
    // });
  }

  logoutAction() {
    box.write(KEY_TOKEN, null);
    box.write(KEY_USER, null);
    goToPage(LoginScreen(), dismissAllPage: true);
  }

  void apiProfile() async {
    loadingProfile.value = true;

    try{
      final resp = await dio.get("$urlProfile");
      checkLogin(resp);
      loadingProfile.value = false;

      try {
        ProfileResponse response = ProfileResponse.fromJson(resp.data);
        if (response.data != null) {
          box.write(KEY_USER, response.data!);
          user.value = response.data!;
          getCurrentUser();
        } else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    }catch(_){
      loadingProfile.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetMyEvents({Function? onFinish}) async {
    try {
      final resp = await dio.get("$urlMyEvent");
      checkLogin(resp);
      try {
        ListMyeventResponse response = ListMyeventResponse.fromJson(resp.data);
        if (response.data != null) {
          totalTransactionSuccess.value = response.data!.length;
          if (onFinish != null) onFinish();
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
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetEventOrder() async {
    loadingEventOrder.value = true;

    try{
      final resp = await dio.get("$urlEvent?limit=5&page=${currentPage.value}");
      checkLogin(resp);
      loadingEventOrder.value = false;

      try {
        EventPaginationResponse response =
        EventPaginationResponse.fromJson(resp.data);
        if (response.data != null) {
          events.clear();
          events.addAll(response.data!.data!);
          totalPages.value = response.data!.totalPage!;
        } else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    }catch(_){
      loadingEventOrder.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
