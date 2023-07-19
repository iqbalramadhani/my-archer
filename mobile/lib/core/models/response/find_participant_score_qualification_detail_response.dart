import 'package:json_annotation/json_annotation.dart';

import '../objects/objects.dart';
import 'response.dart';

part 'find_participant_score_qualification_detail_response.g.dart';

@JsonSerializable()
class FindParticipantScoreQualificationDetailResponse extends BaseResponse {
  DataFindParticipantScoreDetailModel? data;

  FindParticipantScoreQualificationDetailResponse();

  factory FindParticipantScoreQualificationDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      _$FindParticipantScoreQualificationDetailResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FindParticipantScoreQualificationDetailResponseToJson(this);
}

@JsonSerializable()
class DataFindParticipantScoreDetailModel{
  ParticipantModel? participant;
  ScoreModel? score;
  String? budrestNumber;
  dynamic session;
  int? scheduleId;
  int? isUpdated;


  DataFindParticipantScoreDetailModel(
      {this.participant,
      this.score,
      this.budrestNumber,
      this.session,
      this.isUpdated});

  factory DataFindParticipantScoreDetailModel.fromJson(
          Map<String, dynamic> json) =>
      _$DataFindParticipantScoreDetailModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataFindParticipantScoreDetailModelToJson(this);
}
