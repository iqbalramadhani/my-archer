import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/core/services/api_services.dart';
import 'package:myarchery_archer/ui/pages/profile/edit_profile/edit_profile_screen.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/event_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/profile_response.dart';
import '../../login/login_screen.dart';

class ProfileController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxBool loadingProfile = false.obs;
  RxBool loadingEventOrder = false.obs;
  Rx<ProfileModel> user = ProfileModel().obs;
  RxList<EventModel> events = <EventModel>[].obs;
  RxBool isHeaderHide = false.obs;

  RxString btnStatusVerify = "".obs;
  RxString contentStatusVerify = "".obs;

  initController(){
    btnStatusVerify.value = Translator.verify.tr;
    contentStatusVerify.value = Translator.pleaseVerifyDataToFollowMatch.tr;

    getCurrentUser();
    apiProfile();
  }

  getCurrentUser(){
    if(box.read(KEY_USER) != null){
      try {
        user.value = box.read(KEY_USER);
      } catch (_) {
        user.value = ProfileModel.fromJson(box.read(KEY_USER));
      }
    }

    if(user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED){
      contentStatusVerify.value = Translator.pleaseVerifyDataToFollowMatch.tr;
      btnStatusVerify.value = Translator.verify.tr;
    }else if(user.value.verifyStatus == KEY_VERIFY_ACC_SENT){
      contentStatusVerify.value = Translator.yourAccountRequestedVerify.tr;
      btnStatusVerify.value = Translator.seeDetail.tr;
    }else if(user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED){
      contentStatusVerify.value = "${Translator.requestRejected.tr} ${user.value.reasonRejected}";
      btnStatusVerify.value = Translator.reRequest.tr;
    }else if(user.value.verifyStatus == KEY_VERIFY_ACC_VERIFIED){
      contentStatusVerify.value = Translator.yourAccountVerified.tr;
      btnStatusVerify.value = "";
    }
  }

  logoutAction(){
    box.write(KEY_TOKEN, null);
    box.write(KEY_USER, null);
    goToPage(LoginScreen(), dismissAllPage: true);
  }

  void apiProfile({Function? onFinish}) async {
    loadingProfile.value = true;

    final resp = await dio.get("$urlProfile");
    checkLogin(resp);
    loadingProfile.value = false;

    try {
      ProfileResponse response = ProfileResponse.fromJson(resp.data);
      if(response.data != null){
        box.write(KEY_USER, response.data!);
        user.value = response.data!;
        getCurrentUser();

        if(response.data!.verifyStatus == KEY_VERIFY_ACC_VERIFIED && (response.data!.avatar == null || response.data!.avatar.toString().isEmpty)){
          modalBottomVerifyAccount(title: Translator.verifyPhotoProfile.tr, content: Translator.thereIsUpdateNeedUploadPhoto.tr,
              btnPos: Translator.goToEditProfile.tr,
              onVerifyClicked: (){
                goToPage(EditProfileScreen());
              }, skipable: true);
        }

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
  }

  @override
  void onClose() {
    super.onClose();
  }
}