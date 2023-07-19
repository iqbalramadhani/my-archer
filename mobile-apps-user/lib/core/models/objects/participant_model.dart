

import 'package:json_annotation/json_annotation.dart';

import 'club_model.dart';
import 'member_model.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel {
  int? participantId;
  int? id;
  int? eventId;
  int? userId;
  String? name;
  String? type;
  String? email;
  dynamic phoneNumber;
  String? club;
  int? age;
  String? avatar;
  String? gender;
  String? teamCategoryId;
  String? ageCategoryId;
  String? competitionCategoryId;
  int? distanceId;
  String? qualificationDate;
  int? transactionLogId;
  String? uniqueId;
  String? teamName;
  String? createdAt;
  String? updatedAt;
  int? eventCategoryId;

  int? status;
  int? clubId;
  DetailClubModel? clubDetail;
  List<MemberModel>? members;
  String? statusLabel;
  String? categoryLabel;

  ParticipantModel();

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
}
