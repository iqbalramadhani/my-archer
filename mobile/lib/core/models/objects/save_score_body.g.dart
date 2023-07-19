// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_score_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveScoreBody _$SaveScoreBodyFromJson(Map<String, dynamic> json) =>
    SaveScoreBody(
      schedule_id: json['schedule_id'] as int?,
      target_no: json['target_no'] as String?,
      type: json['type'] as int?,
      save_permanent: json['save_permanent'] as int?,
      code: json['code'] as String?,
      shoot_scores: json['shoot_scores'] == null
          ? null
          : ScoreModel.fromJson(json['shoot_scores'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaveScoreBodyToJson(SaveScoreBody instance) =>
    <String, dynamic>{
      'schedule_id': instance.schedule_id,
      'target_no': instance.target_no,
      'type': instance.type,
      'save_permanent': instance.save_permanent,
      'code': instance.code,
      'shoot_scores': instance.shoot_scores,
    };
