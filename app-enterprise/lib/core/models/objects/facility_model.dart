

import 'package:json_annotation/json_annotation.dart';

part 'facility_model.g.dart';

@JsonSerializable()
class FacilityModel {
  int? id;
  String? name;
  String? icon;
  int? eoId;
  int? isHide;
  String? createdAt;
  String? updatedAt;
  bool? checked;


  FacilityModel(
      {this.id,
      this.name,
      this.icon,
      this.eoId,
      this.createdAt,
      this.updatedAt,
      this.checked});

  factory FacilityModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityModelToJson(this);
}
