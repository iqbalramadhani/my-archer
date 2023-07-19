

import 'package:json_annotation/json_annotation.dart';

part 'option_distance_model.g.dart';

@JsonSerializable()
class OptionDistanceModel {
  int? id;
  int? distance;
  int? eoId;
  String? createdAt;
  String? updatedAt;
  bool? checked;


  OptionDistanceModel(
      {this.id, this.distance, this.eoId, this.createdAt, this.updatedAt, this.checked});

  factory OptionDistanceModel.fromJson(Map<String, dynamic> json) =>
      _$OptionDistanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionDistanceModelToJson(this);
}
