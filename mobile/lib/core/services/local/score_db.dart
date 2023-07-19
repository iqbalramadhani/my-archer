import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/models/response/response.dart';
import 'package:my_archery/core/models/saved_elimination_model.dart';

import '../../../utils/key_storage.dart';
import '../../models/saved_scoresheet_model.dart';

class ScoreDb {
  static final ScoreDb _singleton = ScoreDb._internal();
  var box = GetStorage();

  factory ScoreDb() {
    return _singleton;
  }

  ScoreDb._internal();

  int getCurrentTimestamp() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  List<SavedScoresheetModel> readLocalQualificationScores(){
    print("call local elimination score");
    List<SavedScoresheetModel> data = <SavedScoresheetModel>[];
    if(box.read(KEY_SCORE) != null){
      SavedScoresheetModel savedData;
      for (var item in box.read(KEY_SCORE)) {
        try{
          List<DataFindParticipantScoreDetailModel> participants = <DataFindParticipantScoreDetailModel>[];
          for(var itm in item.data){
            participants.add(itm);
          }

          participants.sort((a, b) {
            return a.budrestNumber!.toLowerCase().compareTo(b.budrestNumber!.toLowerCase());
          });
          savedData = SavedScoresheetModel(item.bantalan, item.schedulId, participants);
        }catch(_){
          List<DataFindParticipantScoreDetailModel> participants = <DataFindParticipantScoreDetailModel>[];
          for(var itm in item['data']){
            participants.add(DataFindParticipantScoreDetailModel.fromJson(itm));
          }
          participants.sort((a, b) {
            return a.budrestNumber!.toLowerCase().compareTo(b.budrestNumber!.toLowerCase());
          });

          savedData = SavedScoresheetModel(item['bantalan'], item['schedulId'], participants);
        }
        data.add(savedData);
      }
    }

    return data;
  }

  saveQualifcationScore(dynamic data){
    box.write(KEY_SCORE, data);
  }
  
  deleteAllQualificationScore(){
    box.write(KEY_SCORE, null);
  }

  deleteSingleQualificationScore({required String scheduleId}){
    List<SavedScoresheetModel> data = <SavedScoresheetModel>[];
    data.addAll(readLocalQualificationScores());
    data.removeAt(data.indexWhere((element) => element.schedulId == scheduleId));
    saveQualifcationScore(data);
  }


  List<SavedEliminationModel> readLocalEliminationScores(){
    print("call local elimination score");
    List<SavedEliminationModel> data = <SavedEliminationModel>[];
    if(box.read(KEY_SCORE_ELIMINATION) != null){
      SavedEliminationModel savedData;
      for (var item in box.read(KEY_SCORE_ELIMINATION)) {
        try{
          savedData = SavedEliminationModel(item.bantalan, item.code, item.data);
        }catch(_){
          var data = FindParticipantScoreEliminationDetailResponse.fromJson(item['data']);
          print("dataaaa => ${data.message}");
          savedData = SavedEliminationModel(item['bantalan'], item['code'], data);
        }
        data.add(savedData);
      }
    }

    return data;
  }

  saveEliminationScore(dynamic data){
    box.write(KEY_SCORE_ELIMINATION, data);
  }

  deleteAllEliminationScore(){
    box.write(KEY_SCORE_ELIMINATION, null);
  }

  deleteSingleEliminationScore({required String code}){
    List<SavedEliminationModel> data = <SavedEliminationModel>[];
    data.addAll(readLocalEliminationScores());
    data.removeAt(data.indexWhere((element) => element.code == code));
    saveEliminationScore(data);
  }

}