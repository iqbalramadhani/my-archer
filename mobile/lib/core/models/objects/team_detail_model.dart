

import 'package:json_annotation/json_annotation.dart';

import 'club_model.dart';

part 'team_detail_model.g.dart';

@JsonSerializable()
class TeamDetailModel {
  int? participantId;
  String? teamName;
  ClubModel? club;

  TeamDetailModel();

  factory TeamDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TeamDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDetailModelToJson(this);
}
