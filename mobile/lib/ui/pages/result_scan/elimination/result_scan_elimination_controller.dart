
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/models/saved_elimination_model.dart';
import 'package:my_archery/core/services/local/score_db.dart';
import 'package:my_archery/utils/endpoint.dart';

import '../../../../core/models/response/find_participant_score_elimination_detail_response.dart';
import '../../../../core/services/api_services.dart';
import '../../../../utils/global_helper.dart';
import '../../../shared/loading.dart';
import '../../../shared/toast.dart';
import '../../scoring/elimination/scoresheet/scoresheet_elimination_screen.dart';

class ResultScanEliminationController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  Rx<TextEditingController> bantalanController = TextEditingController().obs;
  Rx<FindParticipantScoreEliminationDetailResponse> dataResp = FindParticipantScoreEliminationDetailResponse().obs;
  RxString code = "".obs;
  RxBool isAnyEmptyBudrest = false.obs;

  List<SavedEliminationModel> data = <SavedEliminationModel>[];

  initController() async {
    data.addAll(ScoreDb().readLocalEliminationScores());
    bantalanController.value.text = dataResp.value.data!.first.budrestNumber!;
    isAnyEmptyBudrest.value = dataResp.value.data!.first.budrestNumber!.isEmpty;
  }

  processConfirm(){
    if(isAnyEmptyBudrest.value){
      if(bantalanController.value.text.isNotEmpty) {
        apiSetBudrestElimination();
      }else{
        errorToast(msg: "Nomor bantalan harus di isi terlebih dahulu");
      }
    }else
      moveToNext();
  }

  savedArcherInfoToDb(){
    data.add(SavedEliminationModel(bantalanController.value.text, code.value, dataResp.value));
    ScoreDb().saveEliminationScore(data);
  }

  Future<void> apiSetBudrestElimination() async {
    var type = "";
    var eliminationId = "";
    var match = "";
    var round = "";

    // `type-${data.eliminationId}-${matchNumber}-${roundNumber}`;

    if (code.value.contains("-")) {
      var splitId = code.value.split("-");

      if (splitId.length < 4) {
        errorToast(msg: "Format Kode yang anda masukkan tidak valid");
        return;
      }

      type = splitId[0];
      eliminationId = splitId[1];
      match = splitId[2];
      round = splitId[3];
    } else {
      errorToast(msg: "Format Kode yang anda masukkan tidak valid");
      return;
    }

    loadingDialog();
    try {
      final resp = await dio.post(urlSetBudrestNumberElimination, data: {
        "elimination_id": eliminationId,
        "match": match,
        "round": round,
        "category_id": code.value.contains("t") ? dataResp.value.data!.first.category!.id.toString() : dataResp.value.data!.first.participant!.eventCategoryId.toString(),
        "budrest_number": bantalanController.value.text.toString()
      });
      Get.back();
      checkLogin(resp);

      if (resp.statusCode.toString().startsWith("2")) {
        moveToNext();
      } else {
        Get.back();
        if (resp.data["errors"] != null) {
          errorToast(msg: getErrorMessage(resp));
        } else
          errorToast(msg: resp.data["message"]);
      }
    } catch (_) {
      Get.back();
      printLog(msg: "error api scan qr => ${_.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if (kDebugMode) {
        msg = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
      }
      errorToast(msg: msg);
    }
  }

  moveToNext(){
    savedArcherInfoToDb();
    goToPage(ScoresheetEliminationScreen(code: code.value,), dismissPage: true);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
