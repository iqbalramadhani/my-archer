

import 'package:json_annotation/json_annotation.dart';

import 'club_model.dart';

part 'detail_participant_model.g.dart';

@JsonSerializable()
class DetailParticipantModel {
  int? idParticipant;
  int? userId;
  String? email;
  dynamic phoneNumber;
  int? age;
  String? gender;
  int? status;
  String? teamName;
  String? orderId;
  // DetailClubModel? clubDetail;
  List<DetailClubModel>? clubDetail;
  String? historyQualification;

  DetailParticipantModel();

  factory DetailParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$DetailParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailParticipantModelToJson(this);
}
