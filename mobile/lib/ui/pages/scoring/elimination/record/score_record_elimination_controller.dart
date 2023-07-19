
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/services/api_services.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/endpoint.dart';
import 'package:my_archery/utils/global_helper.dart';

import '../../../../../../core/models/body/body.dart';
import '../../../../../../core/models/objects/objects.dart';
import '../../../../../../core/models/response/response.dart';


class ScoreRecordEliminationController extends GetxController {
  var box = GetStorage();
  var showKeyboard = true.obs;
  var selectedRow1 = 0.obs;
  var selectedRow2 = 0.obs;
  var currentIndex = 0.obs;
  var sumScore1 = 0.obs;
  var sumScore2 = 0.obs;

  var selectedArcher = 1.obs;

  var sumTextController1 = TextEditingController().obs;
  var sumTextController2 = TextEditingController().obs;

  RxBool isSaveValid = false.obs;
  RxBool isNextValid = false.obs;

  RxBool isLoading = false.obs;
  RxBool isShootOff = false.obs;

  RxInt maxRow = 2.obs;

  RxString typeScoring = "Akumulasi Score".obs;

  Rx<FindParticipantScoreEliminationDetailResponse> data = FindParticipantScoreEliminationDetailResponse().obs;

  //to save input score by admin from ui
  RxList<String> scoreArcher1 = <String>[].obs;
  RxList<String> scoreArcher2 = <String>[].obs;

  //to save all score from all rambahan
  RxList<ShotModel> currentScoreShotMember1 = <ShotModel>[].obs;
  RxList<ShotModel> currentScoreShotMember2 = <ShotModel>[].obs;

  //to save all extra shot score from all ramabahan
  RxList<ExtraShotModel> currentExtraShotScoreShotMember1 = <ExtraShotModel>[].obs;
  RxList<ExtraShotModel> currentExtraShotScoreShotMember2 = <ExtraShotModel>[].obs;

  RxString code = "".obs;
  var type = "";
  var eliminationId = "";
  var match = "";
  var round = "";

  RxInt totalPointMember1 = 0.obs;
  RxInt totalPointMember2 = 0.obs;

  RxInt finalScore1 = 0.obs;
  RxInt finalScore2 = 0.obs;

  RxInt winner = 0.obs;

  Rx<MemberEliminationBody> member1Body = MemberEliminationBody().obs;
  Rx<MemberEliminationBody> member2Body = MemberEliminationBody().obs;

  Rx<MemberEliminationTeamBody> member1TeamBody = MemberEliminationTeamBody().obs;
  Rx<MemberEliminationTeamBody> member2TeamBody = MemberEliminationTeamBody().obs;

  RxList<dynamic> members = <dynamic>[].obs;

  Dio dio = ApiServices().launch();

  initController() async {
    apiScanQrElemination(code.value, currentIndex.value);
  }

  assignNewValue(String? value){
    if(selectedArcher.value == 1) {
      scoreArcher1[selectedRow1.value] = value!;
    }else{
      scoreArcher2[selectedRow2.value] = value!;
    }
  }

  clearAllValue(){
    for(int i = 0; i <= maxRow.value; i++){
        scoreArcher1[i] = "";
        scoreArcher2[i] = "";
    }

    sumScore1.value = 0;
    sumScore2.value = 0;
    winner.value = 0;

    sumTextController1.value.text = "${sumScore1.value}";
    sumTextController2.value.text = "${sumScore2.value}";

    isSaveValid.value = false;
    isNextValid.value = false;
  }

  countSum(){
    if(selectedArcher.value == 1) {
      countArcher1Score();
    }else{
      countArcher2Score();
    }

    isSaveValid.value = sumScore1.value != 0;
    isNextValid.value = !scoreArcher1.contains("") && !scoreArcher2.contains("");
  }

  countArcher1Score(){
    sumScore1.value = 0;
    for (var item in scoreArcher1) {
      if (item.toString() != "") {
        if (item.toString().toUpperCase() == "X") {
          sumScore1.value += 10;
        } else if (item.toString().toUpperCase() == "M") {
          sumScore1.value += 0;
        } else {
          sumScore1.value += int.parse(item.toString());
        }
      }
    }
    sumTextController1.value.text = "${sumScore1.value}";
  }

  countArcher2Score(){
    sumScore2.value = 0;
    for (var item in scoreArcher2) {
      if (item.toString() != "") {
        if (item.toString().toUpperCase() == "X") {
          sumScore2.value += 10;
        } else if (item.toString().toUpperCase() == "M") {
          sumScore2.value += 0;
        } else {
          sumScore2.value += int.parse(item.toString());
        }
      }
    }
    sumTextController2.value.text = "${sumScore2.value}";
  }

  assignBodySaveScore(){
    if(code.value.contains("t")){
      member1TeamBody.value = MemberEliminationTeamBody(
          participant_id: data.value.data!.first.teamDetail!.participantId,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data!.first.scores!.eliminationtScoreType,
            shot: currentScoreShotMember1,
            extraShot: currentExtraShotScoreShotMember1,
            total: data.value.data!.first.scores!.total,
            win: data.value.data!.first.scores!.win,
          )
      );

      member2TeamBody.value = MemberEliminationTeamBody(
          participant_id: data.value.data![1].teamDetail!.participantId,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data![1].scores!.eliminationtScoreType,
            shot: currentScoreShotMember2,
            extraShot: currentExtraShotScoreShotMember2,
            total: data.value.data![1].scores!.total,
            win: data.value.data![1].scores!.win,
          )
      );
    }else{
      member1Body.value = MemberEliminationBody(
          member_id: data.value.data!.first.participant!.member!.id,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data!.first.scores!.eliminationtScoreType,
            shot: currentScoreShotMember1,
            extraShot: currentExtraShotScoreShotMember1,
            total: data.value.data!.first.scores!.total,
            win: data.value.data!.first.scores!.win,
          )
      );

      member2Body.value = MemberEliminationBody(
          member_id: data.value.data![1].participant!.member!.id,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data![1].scores!.eliminationtScoreType,
            shot: currentScoreShotMember2,
            extraShot: currentExtraShotScoreShotMember2,
            total: data.value.data![1].scores!.total,
            win: data.value.data![1].scores!.win,
          )
      );
    }

    members.add(member1Body.value);
    members.add(member2Body.value);

    countArcher1Score();
    countArcher2Score();
  }

  Future<void> apiScanQrElemination(String code, int idx) async {
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

          maxRow.value = response.data!.first.scores!.shot!.first.score!.length - 1;

          scoreArcher1.clear();
          scoreArcher2.clear();
          for(int i=0; i < response.data!.first.scores!.shot!.first.score!.length; i++){
            scoreArcher1.add("");
            scoreArcher2.add("");
          }

          //assign current score
          currentScoreShotMember1.addAll(response.data!.first.scores!.shot!);
          currentScoreShotMember2.addAll(response.data![1].scores!.shot!);

          //assign value in item shoot circle row
          for(int i =0; i<= maxRow.value; i ++){
            scoreArcher1[i] = response.data!.first.scores!.shot![idx].score![i].toString();
            scoreArcher2[i] = response.data![1].scores!.shot![idx].score![i].toString();
          }

          //set active archer
          if(scoreArcher1.any((element) => element.isEmpty)){
            selectedArcher.value = 1;
            selectedRow1.value = scoreArcher1.indexWhere((element) => element.isEmpty);
          }else if(scoreArcher2.any((element) => element.isEmpty)){
            selectedArcher.value = 2;
            selectedRow2.value = scoreArcher2.indexWhere((element) => element.isEmpty);
          }


          //set button valid where all shoot filled
          isSaveValid.value = scoreArcher1.where((element) => element == "").isEmpty && scoreArcher2.where((element) => element == "").isEmpty;
          isNextValid.value = scoreArcher1.where((element) => element == "").isEmpty && scoreArcher2.where((element) => element == "").isEmpty;

          //assign current score extra shot
          currentExtraShotScoreShotMember1.addAll(response.data!.first.scores!.extraShot!);
          currentExtraShotScoreShotMember2.addAll(response.data!.first.scores!.extraShot!);

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
          }else{
            typeScoring.value = "Akumulasi Score";
            finalScore1.value = data.value.data!.first.scores!.total!;
            finalScore2.value = data.value.data![1].scores!.total!;
          }

          //set shoot off
          if(data.value.data!.first.scores!.shot!.any((element) => element.status != "draw") && data.value.data![1].scores!.shot!.any((element) => element.status != "draw")){

          }else{
            isShootOff.value = (finalScore1.value == finalScore2.value);
            if(isShootOff.value){
              errorToast(msg: "Shoot Off begin!");
              Navigator.pop(Get.context!,true);
            }
          }

          //set winner trophy
          if(data.value.data!.first.scores!.shot![idx].status == "win"){
            winner.value = 1;
          }else if(data.value.data![1].scores!.shot![idx].status == "win"){
            winner.value = 2;
          }


          assignBodySaveScore();
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (e) {
        printLog(msg: "error api scan qr => ${e.toString()}");
        var msg = "Terjadi kesalahan. Harap ulangi kembali";
        if(kDebugMode){
          msg    = "Terjadi kesalahan. Harap ulangi kembali ${e.toString()}";
        }
        errorToast(msg: msg);
      }
    }catch(e){
      isLoading.value = false;
      printLog(msg: "error api scan qr => ${e.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if(kDebugMode){
        msg    = "Terjadi kesalahan. Harap ulangi kembali ${e.toString()}";
      }
      errorToast(msg: msg);
    }
  }

  Future<void> apiSaveScore(int type, bool needClose) async {
    loadingDialog();

    try{
      var scores = <String>[];
      scores.addAll(scoreArcher1);
      currentScoreShotMember1[currentIndex.value] = ShotModel(
          total: currentScoreShotMember1[currentIndex.value].total,
          point: currentScoreShotMember1[currentIndex.value].point,
          status: currentScoreShotMember1[currentIndex.value].status,
          score: scores
      );

      var scores2 = <String>[];
      scores2.addAll(scoreArcher2);
      currentScoreShotMember2[currentIndex.value] = ShotModel(
          total: currentScoreShotMember2[currentIndex.value].total,
          point: currentScoreShotMember2[currentIndex.value].point,
          status: currentScoreShotMember2[currentIndex.value].status,
          score: scores2
      );

      if(code.value.contains("t")) {
        member1TeamBody.value.scores?.shot = currentScoreShotMember1;
        member2TeamBody.value.scores?.shot = currentScoreShotMember2;
        members[0] = member1TeamBody.value;
        members[1] = member2TeamBody.value;
      }else{
        member1Body.value.scores!.shot = currentScoreShotMember1;
        member2Body.value.scores!.shot = currentScoreShotMember2;
        members[0] = member1Body.value;
        members[1] = member2Body.value;
      }

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

      final resp = await dio.post(urlSaveTempScore, data: body.toJson());
      Get.back();
      checkLogin(resp);

      try {
        AddScoreEliminationResponse response = AddScoreEliminationResponse.fromJson(resp.data);
        if (response.data != null) {

          if(needClose){
            Navigator.pop(Get.context!, true);
          }else {
            // print("no need close ${currentIndex.value} ${currentScoreShotMember1.length}");
            if (currentIndex.value < currentScoreShotMember1.length) {
              currentIndex.value += 1;
              // print("index up ${currentIndex.value}");
              apiScanQrElemination(code.value, currentIndex.value);
            }
          }

          currentScoreShotMember1.clear();
          currentScoreShotMember2.clear();
          currentExtraShotScoreShotMember1.clear();
          currentExtraShotScoreShotMember2.clear();
          finalScore1.value = 0;
          finalScore2.value = 0;
          totalPointMember1.value = 0;
          totalPointMember2.value = 0;
          selectedRow1.value = 0;
          selectedRow2.value = 0;

          clearAllValue();


        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (e) {
        printLog(msg: "error api save score => ${e.toString()}");
        var msg = "Terjadi kesalahan. Harap ulangi kembali";
        if(kDebugMode){
          msg    = "Terjadi kesalahan. Harap ulangi kembali ${e.toString()}";
        }
        errorToast(msg: msg);
      }
    }catch(e){
      Get.back();
      printLog(msg: "error api save score => ${e.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if(kDebugMode){
        msg    = "Terjadi kesalahan. Harap ulangi kembali ${e.toString()}";
      }
      errorToast(msg: msg);
    }
  }

  backProcess(BuildContext context){
    if(showKeyboard.value){
      showKeyboard.value = false;
      return;
    }

    Navigator.pop(Get.context!, true);
  }
  
  moveToNext(){
    // print("selected archer => ${selectedArcher.value}");
    if(selectedArcher.value == 1) {
      // print("selected row => ${selectedRow1.value}");
      if(selectedRow1.value < maxRow.value)
        selectedRow1.value += 1;
      else if(selectedRow1.value == maxRow.value){
        // showKeyboard.value = false;
        selectedArcher.value = 2;
        selectedRow2.value = 0;
      }
    }else{
      if(selectedRow2.value < maxRow.value)
        selectedRow2.value += 1;
      else showKeyboard.value = false;
    }
  }

  moveToPrev(){
    if(selectedArcher.value == 1) {
      selectedRow1.value -= 1;
    }else{
      if(selectedRow2.value == 0){
        selectedArcher.value = 1;
        selectedRow1.value = maxRow.value;
        return;
      }
      selectedRow2.value -= 1;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
