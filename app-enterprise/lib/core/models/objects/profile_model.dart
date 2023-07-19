

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/event_organizer_model.dart';
import 'package:myarcher_enterprise/core/models/objects/role_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  int? id;
  String? name;
  String? dateOfBirth;
  String? placeOfBirth;
  dynamic phoneNumber;
  dynamic avatar;
  dynamic createdAt;
  dynamic updatedAt;
  int? eoId;

  ProfileModel();

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

@JsonSerializable()
class RoleProfileModel {

  RoleModel? role;
  EventOrganizerModel? eventOrganizers;

  RoleProfileModel();

  factory RoleProfileModel.fromJson(Map<String, dynamic> json) =>
      _$RoleProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoleProfileModelToJson(this);
}
