import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/models/response/response.dart';
import 'package:my_archery/core/models/saved_scoresheet_model.dart';
import 'package:my_archery/core/services/api_services.dart';
import 'package:my_archery/ui/pages/result_scan/id_card/result_scan_idcard_screen.dart';
import 'package:my_archery/utils/endpoint.dart';

import '../../../../utils/global_helper.dart';
import '../../../shared/loading.dart';
import '../../../shared/toast.dart';

class ScanQrIdCardController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxBool isFlashOn = false.obs;
  var idArcherControler = TextEditingController().obs;
  List<SavedScoresheetModel> data = <SavedScoresheetModel>[];

  initController() async {

  }

  Future<void> apiScanQrIdCard(String id) async {
    var ids = id.split(" ");
    loadingDialog();
    try{
      final resp = await dio.get(urlScanQrIdCard, queryParameters: {
        "event_id" : ids[0],
        "code" : ids[1]
      });
      Get.back();
      checkLogin(resp);

      try {
        var response  = BaseResponse.fromJson(resp.data);
        if (resp.data['data'] != null) {
          goToPage(ResultScanIdCardScreen(idCardUrl: resp.data['data']['url']));
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: _.toString());
        errorToast(msg: "Terjadi kesalahan, harap ulangi kembali");
      }
    }catch(e){
      Get.back();
      printLog(msg: e.toString());
      errorToast(msg: "Terjadi kesalahan, harap ulangi kembali");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
