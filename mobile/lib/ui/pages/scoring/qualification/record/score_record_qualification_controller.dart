
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/models/saved_scoresheet_model.dart';
import 'package:my_archery/core/services/api_services.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/endpoint.dart';
import 'package:my_archery/utils/global_helper.dart';

import '../../../../../core/models/objects/objects.dart';
import '../../../../../core/models/response/response.dart';

class ScoreRecordQualificationController extends GetxController {
  var box = GetStorage();
  Dio dio = ApiServices().launch();

  var showKeyboard = true.obs;
  var selectedRow = 0.obs;
  var currentIndex = 0.obs;
  var sumScore = 0.obs;
  var sumTextController = TextEditingController().obs;
  var changedValue = false.obs;
  RxList<dynamic> selectedScore = <dynamic>[].obs;
  Rx<SavedScoresheetModel> selectedSavedArcher = SavedScoresheetModel.empty().obs;
  Rx<DataFindParticipantScoreDetailModel> tempData = DataFindParticipantScoreDetailModel().obs;
  RxString scheduleId = "".obs;


  initController() async {

  }

  assignNewValue(int indexRambahan, String? value){
    changedValue.value = true;
    if(indexRambahan == 0){
      tempData.value.score!.one![selectedRow.value] = value;
    }else if(indexRambahan == 1){
      tempData.value.score!.two![selectedRow.value] = value;
    }else if(indexRambahan == 2){
      tempData.value.score!.three![selectedRow.value] = value;
    }else if(indexRambahan == 3){
      tempData.value.score!.four![selectedRow.value] = value;
    }else if(indexRambahan == 4){
      tempData.value.score!.five![selectedRow.value] = value;
    }else if(indexRambahan == 5){
      tempData.value.score!.six![selectedRow.value] = value;
    }
  }

  clearAllValue(int indexRambahan){
    changedValue.value = true;
    if(indexRambahan == 0){
      for(int i = 0; i < 6; i++){
        tempData.value.score!.one![i] = "";
        selectedScore[i] = "";
      }
    }else if(indexRambahan == 1){
      for(int i = 0; i < 6; i++){
        tempData.value.score!.two![i] = "";
        selectedScore[i] = "";
      }
    }else if(indexRambahan == 2){
      for(int i = 0; i < 6; i++){
        tempData.value.score!.three![i] = "";
        selectedScore[i] = "";
      }
    }else if(indexRambahan == 3){
      for(int i = 0; i < 6; i++){
        tempData.value.score!.four![i] = "";
        selectedScore[i] = "";
      }
    }else if(indexRambahan == 4){
      for(int i = 0; i < 6; i++){
        tempData.value.score!.five![i] = "";
        selectedScore[i] = "";
      }
    }else if(indexRambahan == 5){
      for(int i = 0; i < 6; i++){
        tempData.value.score!.six![i] = "";
        selectedScore[i] = "";
      }
    }
  }

  setSelectedScore(int indexRambahan){
    selectedScore.clear();
    if(indexRambahan == 0){
      selectedScore.addAll(tempData.value.score!.one!);
    }else if(indexRambahan == 1){
      selectedScore.addAll(tempData.value.score!.two!);
    }else if(indexRambahan == 2){
      selectedScore.addAll(tempData.value.score!.three!);
    }else if(indexRambahan == 3){
      selectedScore.addAll(tempData.value.score!.four!);
    }else if(indexRambahan == 4){
      selectedScore.addAll(tempData.value.score!.five!);
    }else if(indexRambahan == 5){
      selectedScore.addAll(tempData.value.score!.six!);
    }

    countSum();
  }

  countSum(){
    sumScore.value = 0;
    for(var item in selectedScore){
      if(item.toString() != ""){
        if(item.toString().toUpperCase() == "X"){
          sumScore.value += 10;
        }else if(item.toString().toUpperCase() == "M"){
          sumScore.value += 0;
        }else{
          sumScore.value += int.parse(item.toString());
        }
      }
    }
    sumTextController.value.text = "${sumScore.value}";
    // moveToNext();
  }

  backProcess(BuildContext context){
    if(showKeyboard.value){
      showKeyboard.value = false;
      return;
    }

    if(!changedValue.value){
      Get.back(result: true);
      return;
    }
    showConfirmDialog(context, content: "Ada perubahan score yang belum tersimpan. Apakah Anda ingin menyimpannya?", btn1: "Cancel", btn2: "Dont Save", btn3: "Save", onClickBtn1: (){

    }, onClickBtn2: (){
      Get.back(result: true);
    }, onClickBtn3: (){
      apiSaveScore(false);
    });
  }
  
  moveToNext(){
    // int sizeEmpty = selectedScore.where((i) => i == "").toList().length;
    // if(sizeEmpty > 0){
      if(selectedRow.value != 5){
        selectedRow.value += 1;
      }
    // }
  }

  moveToPrev(){
    // int sizeEmpty = selectedScore.where((i) => i == "").toList().length;
    // if(sizeEmpty > 0){
    if(selectedRow.value != 0){
      selectedRow.value -= 1;
    }
    // }
  }

  void apiSaveScore(bool? isNext) async {
    loadingDialog();

    var type = "";
    var sessionId = "";
    if(scheduleId.value.contains("-")) {
      var splitId = scheduleId.value.split("-");
      type = splitId[0];
      sessionId = splitId[1];
    }else{
      type = "1";
      sessionId = scheduleId.value;
    }

    var body = SaveScoreBody(
      schedule_id: int.parse(sessionId),
      target_no: selectedSavedArcher.value.bantalan,
      type: int.parse(type),
      save_permanent: 0,
      code: "$type-${tempData.value.participant!.member!.id}-${tempData.value.session}",
      shoot_scores: tempData.value.score!
    );

    final resp = await dio.post(urlSaveTempScore, data: body);
    Get.back();
    checkLogin(resp);

    try {
      SaveScoreResponse response = SaveScoreResponse.fromJson(resp.data);
      if(response.data != null){
        changedValue.value = false;
        if(!isNext!)
          Get.back(result: true);
        else {
          currentIndex.value += 1;
          setSelectedScore(currentIndex.value);
        }
      }else if(response.errors != null){
        errorToast(msg: getErrorMessage(resp));
      }else if(response.message != null){
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
