
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/services/api_services.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/endpoint.dart';
import 'package:my_archery/utils/global_helper.dart';

import '../../../../../../../core/models/body/body.dart';
import '../../../../../../../core/models/objects/objects.dart';
import '../../../../../../../core/models/response/response.dart';

class ShootOffController extends GetxController {
  var box = GetStorage();
  var showKeyboard = false.obs;
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

  RxString typeScoring = "Akumulasi Score".obs;

  Rx<FindParticipantScoreEliminationDetailResponse> data = FindParticipantScoreEliminationDetailResponse().obs;

  //to save input score by admin from ui
  // RxList<String> scoreArcher1 = <String>[].obs;
  // RxList<String> scoreArcher2 = <String>[].obs;
  RxList<String> scoreDistanceArcher1 = <String>[].obs;
  RxList<String> scoreDistanceArcher2 = <String>[].obs;

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
    // scoreArcher1.add("");
    // scoreArcher1.add("");
    // scoreArcher1.add("");
    //
    // scoreArcher2.add("");
    // scoreArcher2.add("");
    // scoreArcher2.add("");

    scoreDistanceArcher1.add("");
    scoreDistanceArcher1.add("");
    scoreDistanceArcher1.add("");

    scoreDistanceArcher2.add("");
    scoreDistanceArcher2.add("");
    scoreDistanceArcher2.add("");

    apiScanQrElemination(code.value);
  }

  assignNewValue(String? value){
    if(selectedArcher.value == 1) {
      currentExtraShotScoreShotMember1[selectedRow1.value].score = value!;
      if(scoreDistanceArcher1[selectedRow1.value] != ""){
        scoreDistanceArcher1[selectedRow1.value] = "";
        scoreDistanceArcher2[selectedRow1.value] = "";
      }
    }else{
      currentExtraShotScoreShotMember2[selectedRow2.value].score = value!;
      if(scoreDistanceArcher2[selectedRow1.value] != ""){
        scoreDistanceArcher2[selectedRow1.value] = "";
      }
    }
  }

  clearAllValue(){
    // for(int i = 0; i < 3; i++){
    //   scoreArcher1[i] = "";
    //   scoreArcher2[i] = "";
    // }

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

    //show dialog same value
    if(selectedArcher.value == 1){
      if(currentExtraShotScoreShotMember1[selectedRow2.value].score != ""){
        if(currentExtraShotScoreShotMember1[selectedRow1.value].score == currentExtraShotScoreShotMember2[selectedRow1.value].score){
          showKeyboard.value = false;
          showShootOffDistanceDialog(Get.context!, firstMemberName: data.value.data!.first.participant != null ? data.value.data!.first.participant!.member!.name : data.value.data!.first.teamDetail!.teamName,
              secondMemberName: data.value.data![1].participant != null ? data.value.data![1].participant!.member!.name : data.value.data![1].teamDetail!.teamName,
              onClick: (distances){
            scoreDistanceArcher1[selectedRow1.value] = distances[0];
            scoreDistanceArcher2[selectedRow2.value] = distances[1];
          });
        }
      }

    }else if(selectedArcher.value == 2){
      if(selectedRow1.value == selectedRow2.value){
        if(currentExtraShotScoreShotMember1[selectedRow1.value].score == currentExtraShotScoreShotMember2[selectedRow1.value].score){
          showKeyboard.value = false;
          showShootOffDistanceDialog(Get.context!, firstMemberName: data.value.data!.first.participant != null ? data.value.data!.first.participant!.member!.name : data.value.data!.first.teamDetail!.teamName,
              secondMemberName: data.value.data![1].participant != null ? data.value.data![1].participant!.member!.name : data.value.data![1].teamDetail!.teamName,
              onClick: (distances){
              scoreDistanceArcher1[selectedRow1.value] = distances[0];
              scoreDistanceArcher2[selectedRow2.value] = distances[1];
          });
        }
      }
    }

    isSaveValid.value = sumScore1.value != 0 && sumScore2.value != 0;
    isNextValid.value = sumScore1.value != 0 && sumScore2.value != 0;
  }

  countArcher1Score(){
    sumScore1.value = 0;
    for (var item in currentExtraShotScoreShotMember1) {
      if (item.score != "") {
        if (item.score.toUpperCase() == "X") {
          sumScore1.value += 10;
        } else if (item.score.toUpperCase() == "M") {
          sumScore1.value += 0;
        } else {
          sumScore1.value += int.parse(item.score);
        }
      }
    }
    sumTextController1.value.text = "${sumScore1.value}";
  }

  countArcher2Score(){
    sumScore2.value = 0;
    for (var item in currentExtraShotScoreShotMember2) {
      if (item.score != "") {
        if (item.score.toUpperCase() == "X") {
          sumScore2.value += 10;
        } else if (item.score.toUpperCase() == "M") {
          sumScore2.value += 0;
        } else {
          sumScore2.value += int.parse(item.score);
        }
      }
    }
    sumTextController2.value.text = "${sumScore2.value}";
  }

  assignBodySaveScore(){
    members.clear();

    if(code.value.contains("t")){
      member1TeamBody.value = MemberEliminationTeamBody(
          participant_id: data.value.data!.first.teamDetail!.participantId,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data!.first.scores!.eliminationtScoreType,
            shot: data.value.data!.first.scores!.shot,
            extraShot: currentExtraShotScoreShotMember1,
            total: data.value.data!.first.scores!.total,
            win: data.value.data!.first.scores!.win,
          )
      );

      member2TeamBody.value = MemberEliminationTeamBody(
          participant_id: data.value.data![1].teamDetail!.participantId,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data![1].scores!.eliminationtScoreType,
            shot: data.value.data![1].scores!.shot,
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
            shot: data.value.data!.first.scores!.shot,
            extraShot: currentExtraShotScoreShotMember1,
            total: data.value.data!.first.scores!.total,
            win: data.value.data!.first.scores!.win,
          ),
      );

      member2Body.value = MemberEliminationBody(
          member_id: data.value.data![1].participant!.member!.id,
          scores: ScoresEliminationModel(
            eliminationtScoreType: data.value.data![1].scores!.eliminationtScoreType,
            shot: data.value.data![1].scores!.shot,
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

  Future<void> apiScanQrElemination(String id) async {
    if(id.contains("-")) {
      var splitId = id.split("-");

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
        "code" : id
      });
      isLoading.value = false;
      checkLogin(resp);

      try {
        FindParticipantScoreEliminationDetailResponse response = FindParticipantScoreEliminationDetailResponse.fromJson(resp.data);
        if (response.data!.isNotEmpty) {
          currentExtraShotScoreShotMember1.clear();
          currentExtraShotScoreShotMember2.clear();

          data.value = response;

          //assign current score
          currentExtraShotScoreShotMember1.addAll(response.data!.first.scores!.extraShot!);
          currentExtraShotScoreShotMember2.addAll(response.data![1].scores!.extraShot!);

          //assign value in item shoot circle row
          for(int i =0; i< 3; i ++){
            // scoreArcher1[i] = response.data!.first.scores!.extraShot![i].score!;
            // scoreArcher2[i] = response.data![1].scores!.extraShot![i].score!;

            scoreDistanceArcher1[i] = (response.data!.first.scores!.extraShot![i].distanceFromX!.toString() == "0" || response.data!.first.scores!.extraShot![i].distanceFromX!.toString() == "") ? "" : response.data!.first.scores!.extraShot![i].distanceFromX!.toString();
            scoreDistanceArcher2[i] = (response.data![1].scores!.extraShot![i].distanceFromX.toString() == "0" || response.data![1].scores!.extraShot![i].distanceFromX.toString() == "") ? "" : response.data![1].scores!.extraShot![i].distanceFromX!.toString();
          }

          // //assign current score extra shot
          // currentExtraShotScoreShotMember1.addAll(response.data!.first.scores!.extraShot!);
          // currentExtraShotScoreShotMember2.addAll(response.data!.first.scores!.extraShot!);

          for(var item in response.data!.first.scores!.extraShot!){
            totalPointMember1.value += (item.score! == "") ? 0 : (item.score!.toString().toLowerCase() == "x") ? 10 : (item.score!.toString().toLowerCase() == "m") ? 0 : 0;
          }

          for(var item in response.data![1].scores!.extraShot!){
            totalPointMember2.value += (item.score! == "") ? 0 : (item.score!.toString().toLowerCase() == "x") ? 10 : (item.score!.toString().toLowerCase() == "m") ? 0 : 0;
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


          //set winner trophy
          if(data.value.data!.first.scores!.extraShot![currentIndex.value].status == "win"){
            winner.value = 1;
          }else if(data.value.data![1].scores!.extraShot![currentIndex.value].status == "win"){
            winner.value = 2;
          }


          assignBodySaveScore();

          //set button valid where all shoot filled
          isSaveValid.value = sumScore1.value != 0 && sumScore2.value != 0;
          isNextValid.value = sumScore1.value != 0 && sumScore2.value != 0;
        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        // errorToast(msg: "${_.toString()}");
        printLog(msg: "error api scan qr elimination => ${_.toString()}");
        var msg = "Terjadi kesalahan. Harap ulangi kembali";
        if(kDebugMode){
          msg = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
        }
        errorToast(msg: msg);
      }
    }catch(_){
      isLoading.value = false;
      printLog(msg: "error api scan qr elimination => ${_.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if(kDebugMode){
        msg = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
      }
      errorToast(msg: msg);
    }
  }

  Future<void> apiSaveScore(int type, bool needClose) async {
    loadingDialog();

    for(int i =0; i < 3; i++){
      currentExtraShotScoreShotMember1[i] = ExtraShotModel(
        distanceFromX: (scoreDistanceArcher1[i] == "") ? 0 : int.parse(scoreDistanceArcher1[i]),
        score: currentExtraShotScoreShotMember1[i].score,
        status: currentExtraShotScoreShotMember1[i].status,
      );
    }

    for(int i =0; i < 3; i++){
      currentExtraShotScoreShotMember2[i] = ExtraShotModel(
        distanceFromX: (scoreDistanceArcher2[i] == "") ? 0 : int.parse(scoreDistanceArcher2[i]),
        score: currentExtraShotScoreShotMember2[i].score,
        status: currentExtraShotScoreShotMember2[i].status,
      );
    }

    if(code.value.contains("t")) {
      member1TeamBody.value.scores?.extraShot = currentExtraShotScoreShotMember1;
      member2TeamBody.value.scores?.extraShot = currentExtraShotScoreShotMember2;
      members[0] = member1TeamBody.value;
      members[1] = member2TeamBody.value;
    }else{
      member1Body.value.scores!.extraShot = currentExtraShotScoreShotMember1;
      member2Body.value.scores!.extraShot = currentExtraShotScoreShotMember2;
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

    try{
      final resp = await dio.post(urlSaveTempScore, data: body.toJson());
      Get.back();
      checkLogin(resp);

      try {
        AddScoreEliminationResponse response = AddScoreEliminationResponse.fromJson(resp.data);
        if (response.data!) {

          currentExtraShotScoreShotMember1.clear();
          currentExtraShotScoreShotMember2.clear();
          finalScore1.value = 0;
          finalScore2.value = 0;
          totalPointMember1.value = 0;
          totalPointMember2.value = 0;

          clearAllValue();

          if(needClose){
            Navigator.pop(Get.context!, true);
            return;
          }

          if(currentIndex.value < currentExtraShotScoreShotMember1.length){
            currentIndex.value += 1;
          }
          apiScanQrElemination(code.value);


        }else if(response.errors != null){
          errorToast(msg: getErrorMessage(resp));
        }else if(response.message != null){
          errorToast(msg: "${response.message}");
        }
      } catch (_) {
        printLog(msg: "error api save score => ${_.toString()}");
        var msg = "Terjadi kesalahan. Harap ulangi kembali";
        if(kDebugMode){
          msg = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
        }
        errorToast(msg: msg);
      }
    }catch(_){
      Get.back();
      printLog(msg: "error api save score => ${_.toString()}");
      var msg = "Terjadi kesalahan. Harap ulangi kembali";
      if(kDebugMode){
        msg = "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}";
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
    if(selectedArcher.value == 1) {
      selectedArcher.value = 2;
      selectedRow2.value = selectedRow1.value;
    }else{
      if(selectedRow1.value != 2) {
        selectedArcher.value = 1;
      }
    }
  }

  moveToPrev(){
    if(selectedArcher.value == 1) {
      if(selectedRow2.value != 0) {
        selectedArcher.value = 2;
        selectedRow2.value -= 1;
      }
    }else{
      selectedArcher.value = 1;
      selectedRow1.value = selectedRow2.value;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
