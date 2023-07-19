// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_register_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryRegisterEventModel _$CategoryRegisterEventModelFromJson(
    Map<String, dynamic> json) {
  return CategoryRegisterEventModel(
    id: json['id'] as int?,
    eventId: json['eventId'] as int?,
    ageCategoryId: json['ageCategoryId'] as String?,
    competitionCategoryId: json['competitionCategoryId'] as String?,
    distanceId: json['distanceId'] as String?,
    teamCategoryId: json['teamCategoryId'] as String?,
    quota: json['quota'] as int?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    fee: json['fee'] as String?,
    earlyBird: json['earlyBird'] as String?,
    isOpen: json['isOpen'] as bool?,
    isEarlyBird: json['isEarlyBird'] as int?,
    totalParticipant: json['totalParticipant'] as int?,
    categoryLabel: json['categoryLabel'] as String?,
    teamCategoryDetail: json['teamCategoryDetail'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['teamCategoryDetail'] as Map<String, dynamic>),
  )..isHide = json['isHide'] as bool?;
}

Map<String, dynamic> _$CategoryRegisterEventModelToJson(
        CategoryRegisterEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'ageCategoryId': instance.ageCategoryId,
      'competitionCategoryId': instance.competitionCategoryId,
      'distanceId': instance.distanceId,
      'teamCategoryId': instance.teamCategoryId,
      'quota': instance.quota,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'fee': instance.fee,
      'earlyBird': instance.earlyBird,
      'isOpen': instance.isOpen,
      'isEarlyBird': instance.isEarlyBird,
      'isHide': instance.isHide,
      'totalParticipant': instance.totalParticipant,
      'categoryLabel': instance.categoryLabel,
      'teamCategoryDetail': instance.teamCategoryDetail,
    };
