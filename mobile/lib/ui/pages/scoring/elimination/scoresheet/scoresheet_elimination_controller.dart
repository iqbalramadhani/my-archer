
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/models/saved_elimination_model.dart';
import 'package:my_archery/core/services/api_services.dart';
import 'package:my_archery/core/services/local/score_db.dart';
import 'package:my_archery/ui/pages/main/main_screen.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/endpoint.dart';
import 'package:my_archery/utils/global_helper.dart';

import '../../../../../../core/models/body/body.dart';
import '../../../../../../core/models/response/response.dart';

class ScoresheetEliminationController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();
  RxString code = "".obs;

  RxList<SavedEliminationModel> savedArcherData = <SavedEliminationModel>[].obs;
  Rx<FindParticipantScoreEliminationDetailResponse> data = FindParticipantScoreEliminationDetailResponse().obs;
  RxBool isLoading = false.obs;
  RxInt totalPointMember1 = 0.obs;
  RxInt totalPointMember2 = 0.obs;

  RxInt finalScore1 = 0.obs;
  RxInt finalScore2 = 0.obs;

  Rx<MemberEliminationBody> member1Body = MemberEliminationBody().obs;
  Rx<MemberEliminationBody> member2Body = MemberEliminationBody().obs;

  Rx<MemberEliminationTeamBody> member1TeamBody = MemberEliminationTeamBody().obs;
  Rx<MemberEliminationTeamBody> member2TeamBody = MemberEliminationTeamBody().obs;

  RxList<dynamic> members = <dynamic>[].obs;

  RxBool isShootOff = false.obs;
  RxString typeScoring = "Sistem Point".obs;

  RxBool showButtonSubmit = false.obs;

  var type = "";
  var eliminationId = "";
  var match = "";
  var round = "";

  initController() {
    apiScanQrElemination(code.value);
  }

  refreshData(){
    totalPointMember1.value = 0;
    totalPointMember2.value = 0;
    finalScore1.value = 0;
    finalScore2.value = 0;
    apiScanQrElemination(code.value);
  }

  onClickSavedArcher({required index}) {
    code.value = savedArcherData[index].code!;
    apiScanQrElemination(code.value);
  }

  onDeleteSavedArcher({required index}) {
    showConfirmDialog(Get.context!,
        content:
        "Apakah Anda yakin akan menutup bantalan? Skor sudah tersimpan secara otomatis, scan QR untuk kembali membuka bantalan",
        assets: "assets/icons/ic_alert.svg",
        btn2: "Yakin", onClickBtn2: () {

          ScoreDb().deleteSingleEliminationScore(code: savedArcherData[index].code!);
          savedArcherData.removeAt(index);

          if (savedArcherData.isNotEmpty) {
            onClickSavedArcher(index: index > 0 ? index - 1 : 0);
          } else {
            Get.offAll(MainScreen());
          }
        }, btn3: "Cek Kembali", onClickBtn3: () {});
  }

  Future<void> apiScanQrElemination(String code) async {
    if(code.contains("-")) {
      var splitId = code.split("-");

      if(splitId.length < 4){
        errorToast(msg: "Format Kode yang anda masukkan tidak valid");
        return;
      }

      type = splitId[0];
      eliminationId = splitId[1];
      match = splitId[2];
      round = splitId[3];
    }else{
      errorToast(msg: "Format Kode yang anda masukkan tidak valid");
      return;
    }

    isLoading.value = true;
    try{
      final resp = await dio.get(urlScanQr, queryParameters: {
        "elimination_id" : eliminationId,
        "match" : match,
        "round" : round,
        "type" : type,
        "code" : code
      });
      isLoading.value = false;
      checkLogin(resp);

      try {
        FindParticipantScoreEliminationDetailResponse response = FindParticipantScoreEliminationDetailResponse.fromJson(resp.data);
        if (response.data!.isNotEmpty) {
          data.value = response;

          for(var item in response.data!.first.scores!.shot!){
            totalPointMember1.value += item.point ?? 0;
          }

          for(var item in response.data![1].scores!.shot!){
            totalPointMember2.value += item.point ?? 0;
          }

          //set type scoring
          if(data.value.data?.first.scores!.eliminationtScoreType == 1){
            typeScoring.value = "Sistem Point";
            finalScore1.value = totalPointMember1.value;
            finalScore2.value = totalPointMember2.value;

            //set shoot off
            isShootOff.value = (finalScore1.value == 5 && finalScore2.value == 5);
          }else{
            typeScoring.value = "Sistem Akumulasi Score";
            finalScore1.value = data.value.data!.first.scores!.total!;
            finalScore2.value = data.value.data![1].scores!.total!;

            //set shoot off
            if(data.value.data!.first.scores!.shot![4].score!.any((element) => element.toString() != "") && data.value.data![1].scores!.shot![4].score!.any((element) => element.toString() != "")) {
              if((finalScore1.value == finalScore2.value && (finalScore1.value != 0 && finalScore2.value != 0)))
                isShootOff.value = true;
              else {
                // if(data.value.data!.first.scores!.extraShot!.any((element) => element.status != "")){
                //   isShootOff.value = true;
                // }else isShootOff.value = false;
                isShootOff.value = false;
              }
            }
          }

          //set show button submit
          if (typeScoring.value == "Sistem Akumulasi Score") {
            if (data.value.data!.first.scores!.win == 0 && data.value.data![1].scores!.win == 0) {
              //check rambahan 5 apakah sudah shoot semua atau belum
              if (!response.data!.first.scores!.shot![4].score!.toString().contains("") &&
                  !response.data![1].scores!.shot![4].score!.toString().contains("")) {
                //check bahwa blm ada pemenang dan bukan shoot off
                // showButtonSubmit.value = ((data.value.data!.first.scores!.win == 0 && data.value.data![1].scores!.win == 0) && !isShootOff.value);
                if ((data.value.data!.first.scores!.win == 0 &&
                    data.value.data![1].scores!.win == 0)) {
                  if (!isShootOff.value) {
                    showButtonSubmit.value = true;
                  } else {
                    if(data.value.data!.first.scores!.extraShot!.where((element) => element.status.toString().toLowerCase() != "empty").length <= 0){
                      showButtonSubmit.value = false;
                      return;
                    }
                    if (data.value.data!.first.scores!.extraShot!.where((element) => element.status.toString().toLowerCase() != "empty").last.score != data.value.data![1].scores!.extraShot!.where((element) => element.status.toString().toLowerCase() != "empty").last.score) {
                      showButtonSubmit.value = true;
                    } else {
                      if (data.value.data!.first.scores!.extraShot!.where((element) => element.status.toString().toLowerCase() != "empty").last.distanceFromX != data.value.data![1].scores!.extraShot!.where((element) => element.status.toString().toLowerCase() != "empty").last.distanceFromX) {
                        showButtonSubmit.value = true;
                      }else
                      showButtonSubmit.value = false;
                    }
                  }
                } else {
                  showButtonSubmit.value = false;
                }
              } else {
                showButtonSubmit.value = false;
              }
            }else{
              showButtonSubmit.value = false;
            }
          } else {
            if (data.value.data!.first.scores!.win == 0 && data.value.data![1].scores!.win == 0) {
              if (totalPointMember1.value >= 6 || totalPointMember2.value >= 6) {
                if (!isShootOff.value) {
                  showButtonSubmit.value = true;
                } else {
                  if (data.value.data!.first.scores!.extraShot!.any((element) => element.status.toString().toLowerCase() == "win" && data.value.data![1].scores!.extraShot!.any((element) => element.status.toString().toLowerCase() == "win"))) {
                    showButtonSubmit.value = true;
                  } else {
                    showButtonSubmit.value = false;
                  }
                }
              } else {
                if (!response.data!.first.scores!.shot![4].score!.toString().contains("") && !response.data![1].scores!.shot![4].score!.toString().contains("")) {
                  //check bahwa blm ada pemenang dan bukan shoot off
                  if (!isShootOff.value) {
                    showButtonSubmit.value = true;
                  } else {
                    if(data.value.data!.first.scores!.extraShot!.where((element) => element.score.toString().toLowerCase() != "").length <= 0){
                      showButtonSubmit.value = false;
                      return;
                    }
                    if (data.value.data!.first.scores!.extraShot!.where((element) => element.score.toString().toLowerCase() != "").last.score != data.value.data![1].scores!.extraShot!.where((element) => element.score.toString().toLowerCase() != "").last.score) {
                      showButtonSubmit.value = true;
                    } else {
                      if (data.value.data!.first.scores!.extraShot!.where((element) => element.score.toString().toLowerCase() != "").last.distanceFromX != data.value.data![1].scores!.extraShot!.where((element) => element.score.toString().toLowerCase() != "").last.distanceFromX) {
                        showButtonSubmit.value = true;
                      }else
                        showButtonSubmit.value = false;
                    }
                  }
                } else {
                  showButtonSubmit.value = false;
                }
              }
            }else{
              showButtonSubmit.value = false;
            }
          }

          //update local db
          SavedEliminationModel newSaved = SavedEliminationModel(
            response.data!.first.budrestNumber,
            code,
            response
          );
          savedArcherData.where((p0) => p0.code == code).first.code = newSaved.code;
          savedArcherData.where((p0) => p0.code == code).first.bantalan = newSaved.bantalan;
          savedArcherData.where((p0) => p0.code == code).first.data = newSaved.data;

          ScoreDb().saveEliminationScore(savedArcherData);

          assignBodySaveScore();

        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (e) {
        printLog(msg: "error api scan qr 1 => ${e.toString()}");
        var msg = "Terjadi kesalahan. Harap ulangi kembali";
        if(kDebugMode){
          msg    = "Terjadi kesalahan. Harap ulangi kembali ${e.toString()}";
        }
        errorToast(msg: msg);
      }
    }catch(e){
      isLoading.value = false;
      printLog(msg: "error api scan qr 2 => ${e.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if(kDebugMode){
        msg    = "Terjadi kesalahan. Harap ulangi kembali ${e.toString()}";
      }
      errorToast(msg: msg);
    }
  }

  assignBodySaveScore(){
    members.clear();
    if(code.value.contains("t")){
      member1TeamBody.value = MemberEliminationTeamBody(
          participant_id: data.value.data!.first.teamDetail!.participantId,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data!.first.scores!.eliminationtScoreType,
            shot: data.value.data!.first.scores!.shot,
            extraShot: data.value.data!.first.scores!.extraShot,
            total: data.value.data!.first.scores!.total,
            win: data.value.data!.first.scores!.win,
          )
      );

      member2TeamBody.value = MemberEliminationTeamBody(
          participant_id: data.value.data![1].teamDetail!.participantId,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data![1].scores!.eliminationtScoreType,
            shot: data.value.data![1].scores!.shot,
            extraShot: data.value.data![1].scores!.extraShot,
            total: data.value.data![1].scores!.total,
            win: data.value.data![1].scores!.win,
          )
      );
    }else{
      member1Body.value = MemberEliminationBody(
          member_id: data.value.data!.first.participant!.member!.id,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data!.first.scores!.eliminationtScoreType,
            shot: data.value.data!.first.scores!.shot,
            extraShot: data.value.data!.first.scores!.extraShot,
            total: data.value.data!.first.scores!.total,
            win: data.value.data!.first.scores!.win,
          )
      );

      member2Body.value = MemberEliminationBody(
          member_id: data.value.data![1].participant!.member!.id,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data![1].scores!.eliminationtScoreType,
            shot: data.value.data![1].scores!.shot,
            extraShot: data.value.data![1].scores!.extraShot,
            total: data.value.data![1].scores!.total,
            win: data.value.data![1].scores!.win,
          )
      );
    }

    members.add(member1Body.value);
    members.add(member2Body.value);
  }

  Future<void> apiSaveScore(int type, bool needClose) async {
    loadingDialog();

    try{
      var body;
      if(code.value.contains("t")){
        body = EliminationScoreTeamBody(
            elimination_id: int.parse(eliminationId),
            match: int.parse(match),
            round: int.parse(round),
            save_permanent: type,
            type: 2,
            code: "${code.value}",
            participants: members
        );
      }else{
        body = EliminationScoreBody(
            elimination_id: int.parse(eliminationId),
            match: int.parse(match),
            round: int.parse(round),
            save_permanent: type,
            type: 2,
            code: "${code.value}",
            members: members
        );
      }

      // for(var item in members){
      //   for(var itm in item.scores!.shot!){
      //     print("shot => ${itm.score}");
      //   }
      // }

      final resp = await dio.post(urlSaveTempScore, data: body.toJson());
      Get.back();
      checkLogin(resp);

      try {
        AddScoreEliminationResponse response = AddScoreEliminationResponse.fromJson(resp.data);
        if (response.data!) {

          if(needClose){
            Navigator.pop(Get.context!, true);
            return;
          }

          refreshData();

        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: "error api save score => ${_.toString()}");
        var msg = "Terjadi kesalahan. Harap ulangi kembali";
        if(kDebugMode){
          msg    = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
        }
        errorToast(msg: msg);
      }
    }catch(_){
      Get.back();
      printLog(msg: "error api save score => ${_.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if(kDebugMode){
        msg    = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
      }
      errorToast(msg: msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
