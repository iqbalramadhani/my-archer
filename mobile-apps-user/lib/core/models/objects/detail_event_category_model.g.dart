// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_event_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailEventCategoryModel _$DetailEventCategoryModelFromJson(
    Map<String, dynamic> json) {
  return DetailEventCategoryModel()
    ..ageCategoryId = json['ageCategoryId'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['ageCategoryId'] as Map<String, dynamic>)
    ..competitionCategoryId = json['competitionCategoryId'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['competitionCategoryId'] as Map<String, dynamic>)
    ..distanceId = json['distanceId'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['distanceId'] as Map<String, dynamic>)
    ..teamCategoryId = json['teamCategoryId'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['teamCategoryId'] as Map<String, dynamic>)
    ..categoryDetailsId = json['categoryDetailsId'] as int?
    ..quota = json['quota'] as int?
    ..fee = json['fee'] as String?
    ..totalParticipant = json['totalParticipant'] as int?;
}

Map<String, dynamic> _$DetailEventCategoryModelToJson(
        DetailEventCategoryModel instance) =>
    <String, dynamic>{
      'ageCategoryId': instance.ageCategoryId,
      'competitionCategoryId': instance.competitionCategoryId,
      'distanceId': instance.distanceId,
      'teamCategoryId': instance.teamCategoryId,
      'categoryDetailsId': instance.categoryDetailsId,
      'quota': instance.quota,
      'fee': instance.fee,
      'totalParticipant': instance.totalParticipant,
    };
