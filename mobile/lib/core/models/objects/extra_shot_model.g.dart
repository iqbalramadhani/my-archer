// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_shot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraShotModel _$ExtraShotModelFromJson(Map<String, dynamic> json) =>
    ExtraShotModel(
      distanceFromX: json['distanceFromX'],
      score: json['score'],
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ExtraShotModelToJson(ExtraShotModel instance) =>
    <String, dynamic>{
      'distanceFromX': instance.distanceFromX,
      'score': instance.score,
      'status': instance.status,
    };
