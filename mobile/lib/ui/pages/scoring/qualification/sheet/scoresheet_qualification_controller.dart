import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/services/api_services.dart';
import 'package:my_archery/ui/pages/main/main_screen.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/endpoint.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/key_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../../core/models/objects/objects.dart';
import '../../../../../core/models/response/response.dart';
import '../../../../../core/models/saved_scoresheet_model.dart';
import '../../../../../core/services/local/score_db.dart';

class ScoresheetQualificationController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  var selectedBudrestNumber = SavedScoresheetModel.empty().obs;
  var selectedArcher = DataFindParticipantScoreDetailModel().obs;
  RxList<SavedScoresheetModel> savedArcherData = <SavedScoresheetModel>[].obs;
  RxList<DataFindParticipantScoreDetailModel> selectedParticipants = <DataFindParticipantScoreDetailModel>[].obs;
  RxBool isLoading = false.obs;
  Rx<AutoScrollController> participantScrollCtrl = AutoScrollController().obs;
  var xCount = 0.obs;
  var tenCount = 0.obs;
  var totalCount = 0.obs;
  var selectedCode = "".obs;

  var xTextController = TextEditingController().obs;
  var tenTextController = TextEditingController().obs;
  var totalTextController = TextEditingController().obs;

  RxBool validToSubmit = true.obs;

  initController() {
    savedArcherData.addAll(ScoreDb().readLocalQualificationScores());

    if (selectedCode.value == "") {
      selectedBudrestNumber.value = savedArcherData.first;
      selectedCode.value = selectedBudrestNumber.value.schedulId!;
    } else {
      selectedBudrestNumber.value = savedArcherData
          .where((p0) => p0.schedulId == selectedCode.value)
          .first;
    }

    selectedArcher.value = selectedBudrestNumber.value.data!.first;
    selectedParticipants.addAll(selectedBudrestNumber.value.data!);
  }

  onClickSavedArcher({required index}) {
    selectedCode.value = savedArcherData[index].schedulId!;
    selectedArcher.value = savedArcherData[index].data!.first;
    selectedBudrestNumber.value = savedArcherData[index];

    selectedParticipants.clear();
    selectedParticipants.addAll(savedArcherData[index].data!);

    apiScanQr(selectedCode.value);
    participantScrollCtrl.value.scrollToIndex(0, preferPosition: AutoScrollPosition.begin);
  }

  onDeleteSavedArcher({required index}) {
    showConfirmDialog(Get.context!,
        content:
            "Apakah Anda yakin akan menutup bantalan? Skor sudah tersimpan secara otomatis, scan QR untuk kembali membuka bantalan",
        assets: "assets/icons/ic_alert.svg",
        btn2: "Yakin", onClickBtn2: () {

      ScoreDb().deleteSingleQualificationScore(scheduleId: savedArcherData[index].schedulId!);
      savedArcherData.removeAt(index);

      if (savedArcherData.isNotEmpty) {
        onClickSavedArcher(index: index > 0 ? index - 1 : 0);
      } else {
        Get.offAll(MainScreen());
      }
    }, btn3: "Cek Kembali", onClickBtn3: () {});
  }

  setValueKeyParticipant(value) {
    box.write(KEY_ADD_PARTICIPANT, value);
  }

  //to count total X, total X+10, total sum
  countTotalValue() {
    for (var item in selectedArcher.value.score!.one!) {
      countEveryRambahan(item.toString());
    }

    for (var item in selectedArcher.value.score!.two!) {
      countEveryRambahan(item.toString());
    }

    for (var item in selectedArcher.value.score!.three!) {
      countEveryRambahan(item.toString());
    }

    for (var item in selectedArcher.value.score!.four!) {
      countEveryRambahan(item.toString());
    }

    for (var item in selectedArcher.value.score!.five!) {
      countEveryRambahan(item.toString());
    }

    for (var item in selectedArcher.value.score!.six!) {
      countEveryRambahan(item.toString());
    }
  }

  countEveryRambahan(String item) {
    if (item.toUpperCase() == "X") {
      xCount.value += 1;
      totalCount.value += 10;
    } else if (item == "10") {
      tenCount.value += 1;
      totalCount.value += 10;
    } else if (item.toUpperCase() == "M" || item.toUpperCase() == "") {
      totalCount.value += 0;
    } else {
      totalCount.value += int.parse(item);
    }

    xTextController.value.text = "${xCount.value}";
    tenTextController.value.text = "${xCount.value + tenCount.value}";
    totalTextController.value.text = "${totalCount.value}";
  }

  void apiScanQr(String id) async {
    isLoading.value = true;
    try {
      final resp = await dio.get(urlScanQr, queryParameters: {"code": id});
      isLoading.value = false;
      checkLogin(resp);

      try {
        var response;
        List<DataFindParticipantScoreDetailModel> participants = <DataFindParticipantScoreDetailModel>[];
        if (resp.data['data'] is List) {
          participants.clear();
          response = NewFindParticipantScoreQualificationDetailResponse.fromJson(resp.data);
          for(DataFindParticipantScoreDetailModel item in response.data){
            participants.add(DataFindParticipantScoreDetailModel(
              participant: item.participant,
              isUpdated: item.isUpdated,
              score: item.score,
              session: item.session,
                budrestNumber: item.budrestNumber!.isEmpty ? selectedParticipants.where((p0) => p0.participant!.id == item.participant!.id).first.budrestNumber : item.budrestNumber
            ));
          }
        } else {
          participants.clear();
          response = FindParticipantScoreQualificationDetailResponse.fromJson(resp.data);
          var item = response.data;
          var data = DataFindParticipantScoreDetailModel(
              participant: item.participant,
              isUpdated: item.isUpdated,
              score: item.score,
              session: item.session,
              budrestNumber: item.budrestNumber!.isEmpty ? selectedParticipants.where((p0) => p0.participant!.id == item.participant!.id).first.budrestNumber : item.budrestNumber
          );
          participants.add(data);
        }

        // List<DataFindParticipantScoreDetailModel> revParticipants = <DataFindParticipantScoreDetailModel>[];
        participants.sort((a, b) {
          return a.budrestNumber!.toLowerCase().compareTo(b.budrestNumber!.toLowerCase());
        });
        // revParticipants.addAll(participants);

        var budRest = selectedBudrestNumber.value.bantalan;
        SavedScoresheetModel newSaved = SavedScoresheetModel(participants.first.budrestNumber!.isEmpty ? budRest : participants.first.budrestNumber!.replaceAll(new RegExp(r'[^0-9]'),''), id, participants);
        savedArcherData.where((p0) => p0.schedulId == id).first.schedulId = newSaved.schedulId;
        savedArcherData.where((p0) => p0.schedulId == id).first.bantalan = newSaved.bantalan;
        savedArcherData.where((p0) => p0.schedulId == id).first.data = newSaved.data;

        ScoreDb().saveQualifcationScore(savedArcherData);

        if (response.data != null) {
          selectedCode.value = selectedBudrestNumber.value.schedulId!;
          xCount.value = 0;
          tenCount.value = 0;
          totalCount.value = 0;

          validToSubmit.value = (selectedArcher.value.score!.one!
                      .any((element) => element.toString() == "") ||
                  selectedArcher.value.score!.two!
                      .any((element) => element.toString() == "") ||
                  selectedArcher.value.score!.three!
                      .any((element) => element.toString() == "") ||
                  selectedArcher.value.score!.four!
                      .any((element) => element.toString() == "") ||
                  selectedArcher.value.score!.five!
                      .any((element) => element.toString() == "") ||
                  selectedArcher.value.score!.six!
                      .any((element) => element.toString() == ""))
              ? false
              : true;

          countTotalValue();
        } else if (response.errors != null) {
          errorToast(msg: getErrorMessage(resp));
        } else if (response.message != null) {
          errorToast(msg: "${response.message}");
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
      isLoading.value = false;
      printLog(msg: "error api scan qr 2 => ${_.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if (kDebugMode) {
        msg = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
      }
      errorToast(msg: msg);
    }
  }

  void apiSaveScore() async {
    loadingDialog();

    var type = "";
    var schedulId = "";
    if (selectedCode.value.contains("-")) {
      var splitId = selectedCode.value.split("-");
      type = splitId[0];
      schedulId = splitId[1];
    } else {
      type = "1";
      schedulId = selectedCode.value;
    }

    var body = SaveScoreBody(
        schedule_id: int.parse(schedulId),
        target_no: selectedBudrestNumber.value.bantalan!,
        type: int.parse(type),
        save_permanent: 1,
        code: "${selectedCode.value}",
        shoot_scores: selectedArcher.value.score!);

    final resp = await dio.post(urlSaveTempScore, data: body);
    Get.back();
    checkLogin(resp);

    try {
      SaveScoreResponse response = SaveScoreResponse.fromJson(resp.data);
      if (response.data != null) {
        // closeArcher();
      } else if (response.errors != null) {
        errorToast(msg: getErrorMessage(resp));
      } else if (response.message != null) {
        errorToast(msg: "${response.message}");
      }
    } catch (_) {
      errorToast(msg: "${_.toString()}");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
