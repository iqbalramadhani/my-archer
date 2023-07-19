import 'package:json_annotation/json_annotation.dart';

import '../objects/objects.dart';
import '../objects/team_detail_model.dart';
import 'response.dart';

part 'find_participant_score_elimination_detail_response.g.dart';

@JsonSerializable()
class FindParticipantScoreEliminationDetailResponse extends BaseResponse {
  List<DataEliminationParticipantModel>? data;

  FindParticipantScoreEliminationDetailResponse();

  factory FindParticipantScoreEliminationDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      _$FindParticipantScoreEliminationDetailResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FindParticipantScoreEliminationDetailResponseToJson(this);
}

@JsonSerializable()
class DataEliminationParticipantModel extends BaseResponse {

  ParticipantModel? participant;
  ScoresEliminationModel? scores;
  dynamic session;
  int? isUpdated;
  dynamic round;
  String? budrestNumber;

  //only show in elimination beregu
  TeamDetailModel? teamDetail;
  List<ListMemberModel>? listMember;
  ParticipantModel? category;

  DataEliminationParticipantModel();

  factory DataEliminationParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$DataEliminationParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataEliminationParticipantModelToJson(this);
}

@JsonSerializable()
class ScoresEliminationModel {

  List<ShotModel>? shot;
  List<ExtraShotModel>? extraShot;
  int? win;
  int? total;
  int? eliminationtScoreType;
  int? result;


  ScoresEliminationModel(
      {this.shot,
      this.extraShot,
      this.win,
      this.total,
      this.eliminationtScoreType});

  factory ScoresEliminationModel.fromJson(Map<String, dynamic> json) =>
      _$ScoresEliminationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScoresEliminationModelToJson(this);
}

@JsonSerializable()
class ListMemberModel{
  dynamic userId;
  dynamic memberId;
  String? name;


  ListMemberModel();

  factory ListMemberModel.fromJson(
      Map<String, dynamic> json) =>
      _$ListMemberModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ListMemberModelToJson(this);
}