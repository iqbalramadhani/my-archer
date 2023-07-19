// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel()
    ..archeryEventId = json['archeryEventId'] as int?
    ..ageCategoryId = json['ageCategoryId'] as String?
    ..forAge = json['forAge'] as int?
    ..ageCategoryLabel = json['ageCategoryLabel'] as String?
    ..competitionCategoryId = json['competitionCategoryId'] as String?
    ..competitionCategoryLabel = json['competitionCategoryLabel'] as String?
    ..teamCategoryId = json['teamCategoryId'] as String?
    ..teamCategoryLabel = json['teamCategoryLabel'] as String?
    ..distanceId = json['distanceId'] as String?
    ..distanceLabel = json['distanceLabel'] as String?
    ..archeryEventCategoryLabel = json['archeryEventCategoryLabel'] as String?;
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'archeryEventId': instance.archeryEventId,
      'ageCategoryId': instance.ageCategoryId,
      'forAge': instance.forAge,
      'ageCategoryLabel': instance.ageCategoryLabel,
      'competitionCategoryId': instance.competitionCategoryId,
      'competitionCategoryLabel': instance.competitionCategoryLabel,
      'teamCategoryId': instance.teamCategoryId,
      'teamCategoryLabel': instance.teamCategoryLabel,
      'distanceId': instance.distanceId,
      'distanceLabel': instance.distanceLabel,
      'archeryEventCategoryLabel': instance.archeryEventCategoryLabel,
    };
