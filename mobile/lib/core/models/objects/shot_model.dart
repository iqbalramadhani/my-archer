

import 'package:json_annotation/json_annotation.dart';

part 'shot_model.g.dart';

@JsonSerializable()
class ShotModel {
  List<dynamic>? score;
  int? total;
  String? status;
  int? point;


  ShotModel({this.score, this.total, this.status, this.point});

  factory ShotModel.fromJson(Map<String, dynamic> json) =>
      _$ShotModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShotModelToJson(this);
}
