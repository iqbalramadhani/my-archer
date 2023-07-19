// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..dateOfBirth = json['dateOfBirth'] as String?
  ..placeOfBirth = json['placeOfBirth'] as String?
  ..phoneNumber = json['phoneNumber']
  ..avatar = json['avatar']
  ..createdAt = json['createdAt']
  ..updatedAt = json['updatedAt']
  ..eoId = json['eoId'] as int?;

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth,
      'placeOfBirth': instance.placeOfBirth,
      'phoneNumber': instance.phoneNumber,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'eoId': instance.eoId,
    };

RoleProfileModel _$RoleProfileModelFromJson(Map<String, dynamic> json) =>
    RoleProfileModel()
      ..role = json['role'] == null
          ? null
          : RoleModel.fromJson(json['role'] as Map<String, dynamic>)
      ..eventOrganizers = json['eventOrganizers'] == null
          ? null
          : EventOrganizerModel.fromJson(
              json['eventOrganizers'] as Map<String, dynamic>);

Map<String, dynamic> _$RoleProfileModelToJson(RoleProfileModel instance) =>
    <String, dynamic>{
      'role': instance.role,
      'eventOrganizers': instance.eventOrganizers,
    };
