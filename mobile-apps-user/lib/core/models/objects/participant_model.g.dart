// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) {
  return ParticipantModel()
    ..participantId = json['participantId'] as int?
    ..id = json['id'] as int?
    ..eventId = json['eventId'] as int?
    ..userId = json['userId'] as int?
    ..name = json['name'] as String?
    ..type = json['type'] as String?
    ..email = json['email'] as String?
    ..phoneNumber = json['phoneNumber']
    ..club = json['club'] as String?
    ..age = json['age'] as int?
    ..avatar = json['avatar'] as String?
    ..gender = json['gender'] as String?
    ..teamCategoryId = json['teamCategoryId'] as String?
    ..ageCategoryId = json['ageCategoryId'] as String?
    ..competitionCategoryId = json['competitionCategoryId'] as String?
    ..distanceId = json['distanceId'] as int?
    ..qualificationDate = json['qualificationDate'] as String?
    ..transactionLogId = json['transactionLogId'] as int?
    ..uniqueId = json['uniqueId'] as String?
    ..teamName = json['teamName'] as String?
    ..createdAt = json['createdAt'] as String?
    ..updatedAt = json['updatedAt'] as String?
    ..eventCategoryId = json['eventCategoryId'] as int?
    ..status = json['status'] as int?
    ..clubId = json['clubId'] as int?
    ..clubDetail = json['clubDetail'] == null
        ? null
        : DetailClubModel.fromJson(json['clubDetail'] as Map<String, dynamic>)
    ..members = (json['members'] as List<dynamic>?)
        ?.map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..statusLabel = json['statusLabel'] as String?
    ..categoryLabel = json['categoryLabel'] as String?;
}

Map<String, dynamic> _$ParticipantModelToJson(ParticipantModel instance) =>
    <String, dynamic>{
      'participantId': instance.participantId,
      'id': instance.id,
      'eventId': instance.eventId,
      'userId': instance.userId,
      'name': instance.name,
      'type': instance.type,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'club': instance.club,
      'age': instance.age,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'teamCategoryId': instance.teamCategoryId,
      'ageCategoryId': instance.ageCategoryId,
      'competitionCategoryId': instance.competitionCategoryId,
      'distanceId': instance.distanceId,
      'qualificationDate': instance.qualificationDate,
      'transactionLogId': instance.transactionLogId,
      'uniqueId': instance.uniqueId,
      'teamName': instance.teamName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'eventCategoryId': instance.eventCategoryId,
      'status': instance.status,
      'clubId': instance.clubId,
      'clubDetail': instance.clubDetail,
      'members': instance.members,
      'statusLabel': instance.statusLabel,
      'categoryLabel': instance.categoryLabel,
    };
