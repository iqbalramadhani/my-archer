import 'package:json_annotation/json_annotation.dart';
import 'package:my_archery/core/models/response/find_participant_score_qualification_detail_response.dart';

part 'saved_scoresheet_model.g.dart';

@JsonSerializable()
class SavedScoresheetModel {
  String? schedulId;
  String? bantalan;
  List<DataFindParticipantScoreDetailModel>? data;

  SavedScoresheetModel.empty();
  SavedScoresheetModel(this.bantalan, this.schedulId, this.data);



  factory SavedScoresheetModel.fromJson(Map<String, dynamic> json) =>
      _$SavedScoresheetModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavedScoresheetModelToJson(this);
}