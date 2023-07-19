import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/models/response/detail_official_response.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../core/models/objects/event_model.dart';
import '../../../core/models/objects/master_detail_event_category.dart';
import '../../../core/models/objects/v2/category_model_v2.dart';
import '../../../core/models/objects/v2/event_price_model.dart';
import '../../../core/models/objects/v2/master_category_register_event_model.dart';
import '../../../core/models/response/faq_response.dart';
import '../../../core/models/response/v2/category_event_response_v2.dart';
import '../../../core/models/response/v2/detail_event_response_v2.dart';

class DetailEventController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  Rx<EventModel> currentEvent = EventModel().obs;
  Rx<DetailEventResponseV2> currentEventResponse = DetailEventResponseV2().obs;
  Rx<FaqResponse> faqResponse = FaqResponse().obs;
  RxList<CategoryModelV2> categories = <CategoryModelV2>[].obs;
  RxList<MasterDetailEventCategoryModel> finalCategories =
      <MasterDetailEventCategoryModel>[].obs;

  RxList<MasterCategoryRegisterEventV2Model> mastercategoryRegister =
      <MasterCategoryRegisterEventV2Model>[].obs;

  Rx<DataDetailOfficialModel> officialModel = DataDetailOfficialModel().obs;
  RxList<EventPriceModel> dataEventPrice = <EventPriceModel>[].obs;

  RxInt selectedCategory = 0.obs;
  RxInt selectedClassByCategory = 0.obs;
  RxList<String> classBySelectedCategory = <String>[].obs;
  RxList<CategoryModelV2> categoryByClassAndCategory = <CategoryModelV2>[].obs;

  RxBool visibleKuota = true.obs;

  RxBool titleHeaderHide = false.obs;
  RxBool categoryHide = false.obs;
  RxBool isAppBarStick = false.obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingFaq = false.obs;
  RxBool isExpired = false.obs;
  RxBool isOfficial = false.obs;

  initController() async {
    apiGetDetail();
  }

  void apiGetDetail() async {
    isLoading.value = true;

    try {
      var slug = currentEvent.value.eventUrl!.split("/").last;
      Map<String, dynamic> param = {"slug": "$slug"};

      final resp = await dio.get("$urlDetailEventV2", queryParameters: param);
      checkLogin(resp);
      isLoading.value = false;

      try {
        DetailEventResponseV2 response =
            DetailEventResponseV2.fromJson(resp.data);
        if (response.errors == null) {
          currentEventResponse.value = response;
          getDataEventPrice(resp.data);
          apiCategoryEventRegisterv2();
          apiGetOfficial();
          apiGetFaq();
          isExpired.value = getCurrentTimestamp() >
              convertDateFormatIntoTimestamp("yyyy-MM-dd HH:mm:ss",
                  currentEventResponse.value.data!.registrationEndDatetime!);
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

  void apiGetOfficial() async {
    try {
      Map<String, dynamic> param = {"event_id": "${currentEvent.value.id}"};

      final resp = await dio.get("$urlDetailOfficial", queryParameters: param);
      checkLogin(resp);
      try {
        DetailOfficialResponse response =
            DetailOfficialResponse.fromJson(resp.data);
        if (response.errors == null) {
          if (response.data != null) {
            isOfficial.value = true;
            officialModel.value = response.data!;
          }
        } else if (response.errors != null) {
          printLog(msg: "error get official ${getErrorMessage(resp)}");
          // errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          printLog(msg: "error get official ${response.message}");
          // errorToast(msg: "${response.message}");
        }
      } catch (_) {
        var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    } catch (_) {
      printLog(msg: "error get official => $_");
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetFaq() async {
    isLoadingFaq.value = true;

    try {
      Map<String, dynamic> param = {
        "event_id": "${currentEventResponse.value.data?.id}",
        "page": "1",
        "limit": "1000",
      };

      final resp = await dio.get("$urlFaq", queryParameters: param);
      checkLogin(resp);
      isLoadingFaq.value = false;

      try {
        FaqResponse response = FaqResponse.fromJson(resp.data);
        if (response.errors == null) {
          faqResponse.value = response;
        } else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: "error get my club => $_");
        var msg = isDebug() ? "${Translator.failedGetFaq.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
        errorToast(msg: msg);
      }
    } catch (_) {
      printLog(msg: "error get my club => $_");
      isLoadingFaq.value = false;
      var msg = isDebug() ? "${Translator.failedGetFaq.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiCategoryEventRegisterv2() async {
    loadingDialog();

    try {
      Map<String, dynamic> param = {"event_id": "${currentEvent.value.id}"};

      final resp = await dio.get("$urlCategoryEventRegisterV2", queryParameters: param);
      checkLogin(resp);
      Get.back();

      try {
        CategoryEventResponseV2 response =
            CategoryEventResponseV2.fromJson(resp.data);
        if (response.errors == null) {
          categories.addAll(response.data!);

          //add data competition category
          for (var item in categories) {
            var name = "";
            if (!mastercategoryRegister
                .any((element) => element.name == item.competitionCategoryId)) {
              name = item.competitionCategoryId!;
              List<String> classCompetition = <String>[];
              for (var itm in categories
                  .where((p0) => p0.competitionCategoryId == name)) {
                classCompetition.add(itm.classCategory!);
              }
              mastercategoryRegister.add(MasterCategoryRegisterEventV2Model(
                  name: name,
                  classCategory: classCompetition,
                  datas: categories
                      .where((p0) => p0.competitionCategoryId == name)
                      .toList()));
            }
          }

          //assign selected class category
          for (var item in mastercategoryRegister[0].classCategory!) {
            if (!classBySelectedCategory.any((element) => element == item)) {
              classBySelectedCategory.add(item);
            }
          }

          getCurrentCategory();
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
      printLog(msg: "error get category => $_");
      Get.back();
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  getCurrentCategory() {
    categoryByClassAndCategory.clear();
    categoryByClassAndCategory.addAll(categories.where((p0) =>
        p0.competitionCategoryId ==
            mastercategoryRegister[selectedCategory.value].name &&
        p0.classCategory ==
            classBySelectedCategory[selectedClassByCategory.value]));
  }

  getDataEventPrice(dynamic mapValue) {
    mapValue['data']["eventPrice"].forEach((key, value) {
      if (value != null) {
        dataEventPrice.add(EventPriceModel(
            titleEventPrice: key,
            earlyBird: value['earlyBird'],
            endDateEarlyBird: value['endDateEarlyBird'],
            isEarlyBird: value['isEarlyBird'],
            price: value['price']));
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
