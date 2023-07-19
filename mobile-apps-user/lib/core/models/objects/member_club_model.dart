

import 'package:json_annotation/json_annotation.dart';

part 'member_club_model.g.dart';

@JsonSerializable()
class MemberClubModel {
  int? id;
  String? name;
  String? email;
  dynamic phoneNumber;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  String? dateOfBirth;
  String? gender;
  int? memberId;
  int? isAdmin;
  int? age;


  MemberClubModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.avatar,
      this.createdAt,
      this.updatedAt,
      this.dateOfBirth,
      this.gender,
      this.memberId,
      this.isAdmin,
      this.age});

  factory MemberClubModel.fromJson(Map<String, dynamic> json) =>
      _$MemberClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberClubModelToJson(this);
}
