

import 'package:json_annotation/json_annotation.dart';

import 'objects.dart';

part 'save_score_body.g.dart';

@JsonSerializable()
class SaveScoreBody {
  int? schedule_id;
  String? target_no;
  int? type;
  int? save_permanent;
  String? code;
  ScoreModel? shoot_scores;


  SaveScoreBody(
      {this.schedule_id,
      this.target_no,
      this.type,
      this.save_permanent,
        this.code,
      this.shoot_scores});

  factory SaveScoreBody.fromJson(Map<String, dynamic> json) =>
      _$SaveScoreBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveScoreBodyToJson(this);
}
