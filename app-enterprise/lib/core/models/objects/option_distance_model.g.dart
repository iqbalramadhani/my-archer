// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_distance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionDistanceModel _$OptionDistanceModelFromJson(Map<String, dynamic> json) =>
    OptionDistanceModel(
      id: json['id'] as int?,
      distance: json['distance'] as int?,
      eoId: json['eoId'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      checked: json['checked'] as bool?,
    );

Map<String, dynamic> _$OptionDistanceModelToJson(
        OptionDistanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'distance': instance.distance,
      'eoId': instance.eoId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'checked': instance.checked,
    };
