

import 'package:json_annotation/json_annotation.dart';

import '../response/find_participant_score_elimination_detail_response.dart';

part 'member_elimination_team_body.g.dart';

@JsonSerializable()
class MemberEliminationTeamBody {
  int? participant_id;
  ScoresEliminationModel? scores;

  MemberEliminationTeamBody({this.participant_id, this.scores});

  factory MemberEliminationTeamBody.fromJson(Map<String, dynamic> json) =>
      _$MemberEliminationTeamBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MemberEliminationTeamBodyToJson(this);
}
