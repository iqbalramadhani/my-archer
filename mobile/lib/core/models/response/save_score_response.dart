

import 'package:json_annotation/json_annotation.dart';

import 'response.dart';

part 'save_score_response.g.dart';

@JsonSerializable()
class SaveScoreResponse extends BaseResponse {
  DataSaveScoreModel? data;

  SaveScoreResponse();

  factory SaveScoreResponse.fromJson(Map<String, dynamic> json) =>
      _$SaveScoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaveScoreResponseToJson(this);
}

@JsonSerializable()
class DataSaveScoreModel extends BaseResponse {
  int? id;
  dynamic participantMemberId;
  int? total;
  dynamic scoringSession;
  String? scoringDetail;
  dynamic type;
  String? scoringLog;
  String? createdAt;
  String? updatedAt;

  DataSaveScoreModel();

  factory DataSaveScoreModel.fromJson(Map<String, dynamic> json) =>
      _$DataSaveScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataSaveScoreModelToJson(this);
}
