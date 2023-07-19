// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elimination_score_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EliminationScoreBody _$EliminationScoreBodyFromJson(
        Map<String, dynamic> json) =>
    EliminationScoreBody(
      elimination_id: json['elimination_id'] as int?,
      round: json['round'] as int?,
      match: json['match'] as int?,
      type: json['type'] as int?,
      save_permanent: json['save_permanent'] as int?,
      code: json['code'] as String?,
      members: json['members'] as List<dynamic>?,
    );

Map<String, dynamic> _$EliminationScoreBodyToJson(
        EliminationScoreBody instance) =>
    <String, dynamic>{
      'elimination_id': instance.elimination_id,
      'round': instance.round,
      'match': instance.match,
      'type': instance.type,
      'save_permanent': instance.save_permanent,
      'code': instance.code,
      'members': instance.members,
    };
