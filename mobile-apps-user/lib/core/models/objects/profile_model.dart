

import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  int? id;
  String? name;
  String? email;
  dynamic phoneNumber;
  dynamic avatar;
  dynamic createdAt;
  dynamic updatedAt;
  String? dateOfBirth;
  String? gender;
  dynamic nik;
  String? address;
  String? placeOfBirth;
  dynamic addressProvinceId;
  dynamic addressCityId;
  int? verifyStatus;
  String? dateVerified;
  String? reasonRejected;
  String? selfieKtpKk;
  String? ktpKk;
  int? age;
  int? eoId;
  String? statusVerify;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.avatar,
      this.createdAt,
      this.updatedAt,
      this.dateOfBirth,
      this.placeOfBirth,
      this.gender,
      this.age,
      this.eoId});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
