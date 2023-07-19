// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModelV2 _$CategoryModelV2FromJson(Map<String, dynamic> json) {
  return CategoryModelV2()
    ..id = json['id'] as int?
    ..eventId = json['eventId'] as int?
    ..ageCategoryId = json['ageCategoryId'] as String?
    ..competitionCategoryId = json['competitionCategoryId'] as String?
    ..distanceId = json['distanceId'] as String?
    ..teamCategoryId = json['teamCategoryId'] as String?
    ..isShow = json['isShow'] as int?
    ..categoryTeam = json['categoryTeam'] as String?
    ..genderCategory = json['genderCategory'] as String?
    ..labelCategory = json['labelCategory'] as String?
    ..classCategory = json['classCategory'] as String?
    ..quota = json['quota'] as int?
    ..normalFee = json['normalFee'] as String?
    ..earlyBirdFee = json['earlyBirdFee'] as String?
    ..isEarlyBird = json['isEarlyBird'] as int?
    ..totalParticipant = json['totalParticipant'] as int?;
}

Map<String, dynamic> _$CategoryModelV2ToJson(CategoryModelV2 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'ageCategoryId': instance.ageCategoryId,
      'competitionCategoryId': instance.competitionCategoryId,
      'distanceId': instance.distanceId,
      'teamCategoryId': instance.teamCategoryId,
      'isShow': instance.isShow,
      'categoryTeam': instance.categoryTeam,
      'genderCategory': instance.genderCategory,
      'labelCategory': instance.labelCategory,
      'classCategory': instance.classCategory,
      'quota': instance.quota,
      'normalFee': instance.normalFee,
      'earlyBirdFee': instance.earlyBirdFee,
      'isEarlyBird': instance.isEarlyBird,
      'totalParticipant': instance.totalParticipant,
    };
