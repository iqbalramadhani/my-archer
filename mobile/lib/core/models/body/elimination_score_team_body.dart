

import 'package:json_annotation/json_annotation.dart';

part 'elimination_score_team_body.g.dart';

@JsonSerializable()
class EliminationScoreTeamBody {
  int? elimination_id;
  int? round;
  int? match;
  int? type;
  int? save_permanent;
  String? code;
  List<dynamic>? participants;


  EliminationScoreTeamBody(
      {this.elimination_id,
      this.round,
      this.match,
      this.type,
      this.save_permanent,
        this.code,
      this.participants
      });

  factory EliminationScoreTeamBody.fromJson(Map<String, dynamic> json) =>
      _$EliminationScoreTeamBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EliminationScoreTeamBodyToJson(this);
}
