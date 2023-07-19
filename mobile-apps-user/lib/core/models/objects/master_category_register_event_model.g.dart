// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_category_register_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterCategoryRegisterEventModel _$MasterCategoryRegisterEventModelFromJson(
    Map<String, dynamic> json) {
  return MasterCategoryRegisterEventModel(
    name: json['name'] as String?,
    datas: (json['datas'] as List<dynamic>?)
        ?.map((e) =>
            CategoryRegisterEventModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MasterCategoryRegisterEventModelToJson(
        MasterCategoryRegisterEventModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'datas': instance.datas,
    };
