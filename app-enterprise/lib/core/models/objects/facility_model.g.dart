// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityModel _$FacilityModelFromJson(Map<String, dynamic> json) =>
    FacilityModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      eoId: json['eoId'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      checked: json['checked'] as bool?,
    )..isHide = json['isHide'] as int?;

Map<String, dynamic> _$FacilityModelToJson(FacilityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'eoId': instance.eoId,
      'isHide': instance.isHide,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'checked': instance.checked,
    };
