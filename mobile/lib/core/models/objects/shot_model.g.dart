// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShotModel _$ShotModelFromJson(Map<String, dynamic> json) => ShotModel(
      score: json['score'] as List<dynamic>?,
      total: json['total'] as int?,
      status: json['status'] as String?,
      point: json['point'] as int?,
    );

Map<String, dynamic> _$ShotModelToJson(ShotModel instance) => <String, dynamic>{
      'score': instance.score,
      'total': instance.total,
      'status': instance.status,
      'point': instance.point,
    };
