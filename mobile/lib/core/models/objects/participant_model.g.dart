// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) =>
    ParticipantModel(
      id: json['id'] as int?,
      eventId: json['eventId'] as int?,
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'],
      age: json['age'],
      club: json['club'] as String?,
      clubId: json['clubId'],
      gender: json['gender'] as String?,
      teamCategoryId: json['teamCategoryId'] as String?,
      ageCategoryId: json['ageCategoryId'] as String?,
      competitionCategoryId: json['competitionCategoryId'] as String?,
      distanceId: json['distanceId'],
      qualificationDate: json['qualificationDate'] as String?,
      transactionLogId: json['transactionLogId'] as int?,
      uniqueId: json['uniqueId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      categoryLabel: json['categoryLabel'] as String?,
      member: json['member'] == null
          ? null
          : MemberModel.fromJson(json['member'] as Map<String, dynamic>),
    )
      ..teamName = json['teamName'] as String?
      ..eventCategoryId = json['eventCategoryId'];

Map<String, dynamic> _$ParticipantModelToJson(ParticipantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'userId': instance.userId,
      'name': instance.name,
      'type': instance.type,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'age': instance.age,
      'club': instance.club,
      'clubId': instance.clubId,
      'gender': instance.gender,
      'teamCategoryId': instance.teamCategoryId,
      'ageCategoryId': instance.ageCategoryId,
      'competitionCategoryId': instance.competitionCategoryId,
      'distanceId': instance.distanceId,
      'qualificationDate': instance.qualificationDate,
      'transactionLogId': instance.transactionLogId,
      'uniqueId': instance.uniqueId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'teamName': instance.teamName,
      'eventCategoryId': instance.eventCategoryId,
      'categoryLabel': instance.categoryLabel,
      'member': instance.member,
    };
