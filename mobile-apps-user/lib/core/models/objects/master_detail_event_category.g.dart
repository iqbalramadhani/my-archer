// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_detail_event_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDetailEventCategoryModel _$MasterDetailEventCategoryModelFromJson(
    Map<String, dynamic> json) {
  return MasterDetailEventCategoryModel(
    name: json['name'] as String?,
    datas: (json['datas'] as List<dynamic>?)
        ?.map(
            (e) => DetailEventCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MasterDetailEventCategoryModelToJson(
        MasterDetailEventCategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'datas': instance.datas,
    };
