

import 'package:json_annotation/json_annotation.dart';

import '../response/find_participant_score_elimination_detail_response.dart';

part 'member_elimination_body.g.dart';

@JsonSerializable()
class MemberEliminationBody {
  int? member_id;
  ScoresEliminationModel? scores;

  MemberEliminationBody({this.member_id, this.scores});

  factory MemberEliminationBody.fromJson(Map<String, dynamic> json) =>
      _$MemberEliminationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MemberEliminationBodyToJson(this);
}
