// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailModel _$CategoryDetailModelFromJson(Map<String, dynamic> json) {
  return CategoryDetailModel()
    ..id = json['id'] as int?
    ..quota = json['quota'] as int?
    ..fee = json['fee'] as String?
    ..genderCategory = json['genderCategory'] as String?
    ..categoryLabel = json['categoryLabel'] as String?
    ..categoryType = json['categoryType'] as String?
    ..haveSeries = json['haveSeries']
    ..canUpdateSeries = json['canUpdateSeries']
    ..canJoinSeries = json['canJoinSeries']
    ..categoryTeam = json['categoryTeam'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['categoryTeam'] as Map<String, dynamic>)
    ..ageCategoryDetail = json['ageCategoryDetail'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['ageCategoryDetail'] as Map<String, dynamic>)
    ..competitionCategoryDetail = json['competitionCategoryDetail'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['competitionCategoryDetail'] as Map<String, dynamic>)
    ..distanceDetail = json['distanceDetail'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['distanceDetail'] as Map<String, dynamic>)
    ..teamCategoryDetail = json['teamCategoryDetail'] == null
        ? null
        : TeamCategoryDetail.fromJson(
            json['teamCategoryDetail'] as Map<String, dynamic>)
    ..detailParticipant = json['detailParticipant'] == null
        ? null
        : DetailParticipantModel.fromJson(
            json['detailParticipant'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CategoryDetailModelToJson(
        CategoryDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quota': instance.quota,
      'fee': instance.fee,
      'genderCategory': instance.genderCategory,
      'categoryLabel': instance.categoryLabel,
      'categoryType': instance.categoryType,
      'haveSeries': instance.haveSeries,
      'canUpdateSeries': instance.canUpdateSeries,
      'canJoinSeries': instance.canJoinSeries,
      'categoryTeam': instance.categoryTeam,
      'ageCategoryDetail': instance.ageCategoryDetail,
      'competitionCategoryDetail': instance.competitionCategoryDetail,
      'distanceDetail': instance.distanceDetail,
      'teamCategoryDetail': instance.teamCategoryDetail,
      'detailParticipant': instance.detailParticipant,
    };
