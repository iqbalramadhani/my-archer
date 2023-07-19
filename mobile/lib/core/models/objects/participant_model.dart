


import 'package:json_annotation/json_annotation.dart';

import 'member_model.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel {
  int? id;
  int? eventId;
  int? userId;
  String? name;
  String? type;
  String? email;
  dynamic phoneNumber;
  dynamic age;
  String? club;
  dynamic clubId;
  String? gender;
  String? teamCategoryId;
  String? ageCategoryId;
  String? competitionCategoryId;
  dynamic distanceId;
  String? qualificationDate;
  int? transactionLogId;
  String? uniqueId;
  String? createdAt;
  String? updatedAt;
  String? teamName;
  dynamic eventCategoryId;
  String? categoryLabel;
  MemberModel? member;


  ParticipantModel(
      {this.id,
      this.eventId,
      this.userId,
      this.name,
      this.type,
      this.email,
      this.phoneNumber,
      this.age,
      this.club,
      this.clubId,
      this.gender,
      this.teamCategoryId,
      this.ageCategoryId,
      this.competitionCategoryId,
      this.distanceId,
      this.qualificationDate,
      this.transactionLogId,
      this.uniqueId,
      this.createdAt,
      this.updatedAt,
      this.categoryLabel,
      this.member});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
}
