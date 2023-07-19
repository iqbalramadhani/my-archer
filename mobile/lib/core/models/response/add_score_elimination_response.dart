import 'package:json_annotation/json_annotation.dart';

import 'response.dart';

part 'add_score_elimination_response.g.dart';

@JsonSerializable()
class AddScoreEliminationResponse extends BaseResponse {
  bool? data;

  AddScoreEliminationResponse();

  factory AddScoreEliminationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AddScoreEliminationResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AddScoreEliminationResponseToJson(this);
}