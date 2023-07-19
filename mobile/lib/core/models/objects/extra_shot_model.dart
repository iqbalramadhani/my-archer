

import 'package:json_annotation/json_annotation.dart';

part 'extra_shot_model.g.dart';

@JsonSerializable()
class ExtraShotModel {
  dynamic distanceFromX;
  dynamic score;
  String? status;


  ExtraShotModel({this.distanceFromX, this.score, this.status});

  factory ExtraShotModel.fromJson(Map<String, dynamic> json) =>
      _$ExtraShotModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraShotModelToJson(this);
}
