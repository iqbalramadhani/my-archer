// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_category_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamCategoryDetail _$TeamCategoryDetailFromJson(Map<String, dynamic> json) {
  return TeamCategoryDetail(
    id: json['id'],
    label: json['label'] as String?,
  )
    ..type = json['type'] as String?
    ..maxAge = json['maxAge'] as int?;
}

Map<String, dynamic> _$TeamCategoryDetailToJson(TeamCategoryDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': instance.type,
      'maxAge': instance.maxAge,
    };
