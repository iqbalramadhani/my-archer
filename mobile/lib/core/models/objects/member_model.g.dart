// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel()
  ..id = json['id'] as int?
  ..archeryEventParticipantId = json['archeryEventParticipantId'] as int?
  ..name = json['name'] as String?
  ..teamCategoryId = json['teamCategoryId'] as String?
  ..email = json['email'] as String?
  ..phoneNumber = json['phoneNumber']
  ..club = json['club'] as String?
  ..age = json['age']
  ..gender = json['gender'] as String?
  ..qualificationDate = json['qualificationDate'] as String?
  ..createdAt = json['createdAt'] as String?
  ..updatedAt = json['updatedAt'] as String?
  ..birthdate = json['birthdate'] as String?;

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'archeryEventParticipantId': instance.archeryEventParticipantId,
      'name': instance.name,
      'teamCategoryId': instance.teamCategoryId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'club': instance.club,
      'age': instance.age,
      'gender': instance.gender,
      'qualificationDate': instance.qualificationDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'birthdate': instance.birthdate,
    };
