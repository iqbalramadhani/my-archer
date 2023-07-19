

import 'package:json_annotation/json_annotation.dart';

import 'find_participant_score_qualification_detail_response.dart';
import 'response.dart';

part 'new_find_participant_score_qualification_detail_response.g.dart';

@JsonSerializable()
class NewFindParticipantScoreQualificationDetailResponse extends BaseResponse {

  List<DataFindParticipantScoreDetailModel>? data;

  NewFindParticipantScoreQualificationDetailResponse();

  factory NewFindParticipantScoreQualificationDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$NewFindParticipantScoreQualificationDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewFindParticipantScoreQualificationDetailResponseToJson(this);
}