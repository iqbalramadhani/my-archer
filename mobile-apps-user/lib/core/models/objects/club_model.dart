

import 'package:json_annotation/json_annotation.dart';

import 'region_model.dart';

part 'club_model.g.dart';

@JsonSerializable()
class ClubModel {
  DetailClubModel? detail;
  int? totalMember;
  int? isJoin;

  ClubModel();

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClubModelToJson(this);
}

@JsonSerializable()
class DetailClubModel {
  int? id;
  String? name;
  String? logo;
  String? banner;
  String? placeName;
  String? address;
  String? description;
  String? createdAt;
  String? updatedAt;
  dynamic province;
  dynamic city;
  RegionModel? detailProvince;
  dynamic detailCity;
  int? totalMember;
  int? isAdmin;
  int? isJoin;

  DetailClubModel();

  factory DetailClubModel.fromJson(Map<String, dynamic> json) =>
      _$DetailClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailClubModelToJson(this);
}
