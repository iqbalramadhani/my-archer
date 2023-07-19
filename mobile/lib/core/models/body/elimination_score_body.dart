

import 'package:json_annotation/json_annotation.dart';

part 'elimination_score_body.g.dart';

@JsonSerializable()
class EliminationScoreBody {
  int? elimination_id;
  int? round;
  int? match;
  int? type;
  int? save_permanent;
  String? code;
  List<dynamic>? members;


  EliminationScoreBody(
      {this.elimination_id,
      this.round,
      this.match,
      this.type,
      this.save_permanent,
        this.code,
      this.members
      });

  factory EliminationScoreBody.fromJson(Map<String, dynamic> json) =>
      _$EliminationScoreBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EliminationScoreBodyToJson(this);
}
