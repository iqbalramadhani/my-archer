
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/club_model.dart';
import '../../../../core/models/objects/member_club_model.dart';
import '../../../../core/models/response/base_response.dart';
import '../../../../core/models/response/club_member_response.dart';
import '../../../../core/models/response/detail_club_response.dart';

class DetailClubController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxInt idClub = 0.obs;

  RxBool isLoadingClub = false.obs;
  RxBool isLoadingMember = false.obs;

  RxInt currentPage = 1.obs;
  RxBool validLoadMore = false.obs;

  RxString name = "".obs;

  Rx<DetailClubModel> data = DetailClubModel().obs;
  RxList<MemberClubModel> members = <MemberClubModel>[].obs;

  initController() async {
    apiGetProfileClub();
    apiGetMember();
  }

  reloadMember(){
    members.clear();
    currentPage.value = 1;
    validLoadMore.value = false;

    apiGetMember();
  }

  void apiGetProfileClub() async {
    isLoadingClub.value = true;

    try{

      Map<String, dynamic> param = {
        "club_id" : idClub.value,
      };

      final resp = await dio.get("$urlProfileClub", queryParameters: param);
      checkLogin(resp);
      isLoadingClub.value = false;

      try {
        DetailClubResponse response = DetailClubResponse.fromJson(resp.data);
        if(response.errors == null){
          data.value = response.data!;
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
      isLoadingClub.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiGetMember() async {
    isLoadingMember.value = true;

    Map<String, dynamic> param = {
      "club_id" : idClub.value,
      "limit" : 50,
      "page" : currentPage.value,
    };

    if(name.value != "")
      param["name"] = "${name.value}";

    try{
      final resp = await dio.get("$urlMemberClub", queryParameters: param);
      checkLogin(resp);
      isLoadingMember.value = false;

      try {
        ClubMemberResponse response = ClubMemberResponse.fromJson(resp.data);
        if(response.errors == null){
          if(response.data!.isNotEmpty){
            for(var item in response.data!) {
              members.add(item);
            }
            validLoadMore.value = true;
            currentPage.value +=1;
          }else{
            validLoadMore.value = false;
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
      isLoadingMember.value = false;
      var msg = isDebug() ? "${Translator.somethingWentWrong.tr} {${_.toString()}" : Translator.somethingWentWrong.tr;
      errorToast(msg: msg);
    }
  }

  void apiJoinClub(String idClub, {Function? onFinish}) async {
    loadingDialog();

    Map<String, dynamic> param = {
      "club_id" : idClub,
    };

    try{
      final resp = await dio.post("$urlJoinClub", data: param);
      checkLogin(resp);
      Get.back();

      try {
        BaseResponse response = BaseResponse.fromJson(resp.data);
        if(response.errors == null){
          if(onFinish != null){
            onFinish();
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

  void apiLeftClub(String idClub, {Function? onFinish}) async {
    loadingDialog();

    Map<String, dynamic> param = {
      "club_id" : idClub,
    };

    try{
      final resp = await dio.delete("$urlLeftClub", data: param);
      checkLogin(resp);
      Get.back();

      try {
        BaseResponse response = BaseResponse.fromJson(resp.data);
        if(response.errors == null){
          if(onFinish != null){
            onFinish();
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
