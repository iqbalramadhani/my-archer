

import 'package:json_annotation/json_annotation.dart';
import 'package:my_archery/core/models/objects/region_model.dart';

part 'club_model.g.dart';

@JsonSerializable()
class ClubModel {
  int? id;
  String? name;
  String? logo;
  String? banner;
  String? placeName;
  String? address;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? province;
  int? city;
  RegionModel? detailProvince;
  RegionModel? detailCity;
  int? isAdmin;

  ClubModel();

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClubModelToJson(this);
}
