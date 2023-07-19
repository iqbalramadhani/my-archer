
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/models/saved_scoresheet_model.dart';

import '../../../../core/models/response/response.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/local/score_db.dart';
import '../../../../utils/endpoint.dart';
import '../../../../utils/global_helper.dart';
import '../../../shared/loading.dart';
import '../../../shared/toast.dart';
import '../../scoring/qualification/sheet/scoresheet_qualification_screen.dart';

class ResultScanQualificationController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxList<DataFindParticipantScoreDetailModel> currentData = <DataFindParticipantScoreDetailModel>[].obs;
  List<SavedScoresheetModel> data = <SavedScoresheetModel>[];
  RxString code = "".obs;
  RxBool isAnyEmptyBudrest = false.obs;
  RxInt successChangeBudrest = 0.obs;

  initController() async {
    data.addAll(ScoreDb().readLocalQualificationScores());
    isAnyEmptyBudrest.value = currentData.any((element) => element.budrestNumber!.isEmpty);
  }

  savedArcherInfoToDb(schedulId, List<DataFindParticipantScoreDetailModel> dataParticipant){
    List<DataFindParticipantScoreDetailModel>  participants = <DataFindParticipantScoreDetailModel>[];
    participants.addAll(dataParticipant.reversed);
    data.add(SavedScoresheetModel(dataParticipant.first.budrestNumber!.replaceAll(new RegExp(r'[^0-9]'),''), schedulId, participants));
    ScoreDb().saveQualifcationScore(data);
  }
  
  Future<void> setBudrestNumber() async {
    loadingDialog();
    for(var item in currentData){
      apiSetBudrestQualification(item.participant!.eventId.toString(), item.scheduleId.toString(), item.budrestNumber!);
    }
  }

  Future<void> apiSetBudrestQualification(String eventId, String scheduleId, String budrestNumber) async {
    try {
      final resp = await dio.put(urlSetBudrestNumberQualification, queryParameters: {
        "event_id": eventId,
        "schedule_id": scheduleId,
        "bud_rest_number": budrestNumber
      });
      checkLogin(resp);

      if (resp.statusCode.toString().startsWith("2")) {
        successChangeBudrest += 1;
        if(successChangeBudrest.value == currentData.length){
          moveToNext();
        }
      } else {
        if(scheduleId == currentData.last.scheduleId.toString()) {
          Get.back();
          if (resp.data["errors"] != null) {
            errorToast(msg: getErrorMessage(resp));
          } else
            errorToast(msg: resp.data["message"]);
        }
      }
    } catch (_) {
      printLog(msg: "error api scan qr => ${_.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if (kDebugMode) {
        msg = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
      }
      if(scheduleId == currentData.last.scheduleId.toString()) {
        Get.back();
        errorToast(msg: msg);
      }
    }
  }

  moveToNext(){
    savedArcherInfoToDb(code.value, currentData);
    goToPage(ScoresheetQualificationScreen(code: code.value),dismissAllPage: true);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
