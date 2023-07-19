

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/core/models/objects/gallery_model.dart';
import 'package:myarcher_enterprise/core/models/objects/region_model.dart';

part 'venue_model.g.dart';

@JsonSerializable()
class VenueModel {
  int? id;
  int? eoId;
  String? name;
  String? description;
  String? placeType;
  String? phoneNumber;
  dynamic latitude;
  dynamic longitude;
  String? address;
  int? provinceId;
  int? cityId;
  RegionModel? province;
  RegionModel? city;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<GalleryModel>? galleries;
  List<FacilityModel>? otherFacilities;
  List<FacilityModel>? facilities;

  VenueModel();

  factory VenueModel.fromJson(Map<String, dynamic> json) =>
      _$VenueModelFromJson(json);

  Map<String, dynamic> toJson() => _$VenueModelToJson(this);
}
