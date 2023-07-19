import 'package:json_annotation/json_annotation.dart';
import 'package:my_archery/core/models/response/find_participant_score_elimination_detail_response.dart';

part 'saved_elimination_model.g.dart';

@JsonSerializable()
class SavedEliminationModel {
  String? code;
  String? bantalan;
  FindParticipantScoreEliminationDetailResponse? data;

  SavedEliminationModel.empty();
  SavedEliminationModel(this.bantalan, this.code, this.data);



  factory SavedEliminationModel.fromJson(Map<String, dynamic> json) =>
      _$SavedEliminationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavedEliminationModelToJson(this);
}