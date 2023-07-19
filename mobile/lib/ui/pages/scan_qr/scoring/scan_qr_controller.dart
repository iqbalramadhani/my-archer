import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/services/api_services.dart';
import 'package:my_archery/ui/pages/result_scan/qualification/result_scan_qualification_screen.dart';
import 'package:my_archery/ui/pages/scoring/elimination/scoresheet/scoresheet_elimination_screen.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/endpoint.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/key_storage.dart';

import '../../../../core/models/response/response.dart';
import '../../../../core/services/local/score_db.dart';
import '../../result_scan/elimination/result_scan_elimination_screen.dart';
import '../../scoring/qualification/sheet/scoresheet_qualification_screen.dart';

class ScanQrController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  RxBool isFlashOn = false.obs;
  var idArcherControler = TextEditingController().obs;

  initController() async {
  }

  void apiScanQr(String id) async {
    if (!id.contains("-")) {
      errorToast(msg: "Format Kode yang anda masukkan tidak valid");
      return;
    }

    if (box.read(KEY_ADD_PARTICIPANT) == true && id.startsWith("2")) {
      errorToast(msg: "Anda tidak bisa menscan eliminasi saat ini");
      return;
    }

    if (id.startsWith("1")) {
      if (ScoreDb().readLocalQualificationScores().any((element) => element.schedulId == id)) {
        goToPage(ScoresheetQualificationScreen(code: id), dismissPage: true);
        return;
      }
      apiScanQrQualification(id);
    } else if (id.startsWith("2")) {
      if (ScoreDb().readLocalEliminationScores().any((element) => element.code == id)) {
        goToPage(ScoresheetEliminationScreen(code: id), dismissPage: true);
        return;
      }
      apiScanQrElemination(id);
    } else {
      errorToast(msg: "Format Kode yang anda masukkan tidak valid");
    }
  }

  Future<void> apiScanQrQualification(String id) async {
    loadingDialog();
    try {
      final resp = await dio.get(urlScanQr, queryParameters: {"code": id});
      Get.back();
      checkLogin(resp);

      try {
        List<DataFindParticipantScoreDetailModel> data = <DataFindParticipantScoreDetailModel>[];
        var response;
        if (resp.data['data'] is List) {
          response = NewFindParticipantScoreQualificationDetailResponse.fromJson(resp.data);
          data.addAll(response.data);
        } else {
          response = FindParticipantScoreQualificationDetailResponse.fromJson(resp.data);
          data.add(response.data);
        }

        if (response.data != null) {
          goToPage(ResultScanQualificationScreen(code: id, data: data,), dismissPage: true);
        } else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: _.toString());
        errorToast(msg: "Terjadi kesalahan, harap ulangi kembali");
      }
    } catch (e) {
      Get.back();
      printLog(msg: e.toString());
      errorToast(msg: "Terjadi kesalahan, harap ulangi kembali");
    }
  }

  Future<void> apiScanQrElemination(String id) async {
    var type = "";
    var eliminationId = "";
    var match = "";
    var round = "";

    // `type-${data.eliminationId}-${matchNumber}-${roundNumber}`;

    if (id.contains("-")) {
      var splitId = id.split("-");

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
      final resp = await dio.get(urlScanQr, queryParameters: {
        "elimination_id": eliminationId,
        "match": match,
        "round": round,
        "type": type,
        "code": id
      });
      Get.back();
      checkLogin(resp);

      try {
        FindParticipantScoreEliminationDetailResponse response = FindParticipantScoreEliminationDetailResponse.fromJson(resp.data);
        if (response.data != null) {
          if (response.data!.isNotEmpty) {
            goToPage(ResultScanEliminationScreen(data: response, kode: id), dismissPage: true);
          }else
            errorToast(msg: "Data tidak ditemukan");
        }else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
        } else {
          errorToast(msg: "Data tidak ditemukan");
        }
      } catch (_) {
        printLog(msg: "error api scan qr => ${_.toString()}");
        var msg = "Terjadi kesalahan. Harap ulangi kembali";
        if (kDebugMode) {
          msg = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
        }
        errorToast(msg: msg);
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

  @override
  void onClose() {
    super.onClose();
  }
}
