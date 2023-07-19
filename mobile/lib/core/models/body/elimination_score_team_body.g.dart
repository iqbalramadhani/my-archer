// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elimination_score_team_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EliminationScoreTeamBody _$EliminationScoreTeamBodyFromJson(
        Map<String, dynamic> json) =>
    EliminationScoreTeamBody(
      elimination_id: json['elimination_id'] as int?,
      round: json['round'] as int?,
      match: json['match'] as int?,
      type: json['type'] as int?,
      save_permanent: json['save_permanent'] as int?,
      code: json['code'] as String?,
      participants: json['participants'] as List<dynamic>?,
    );

Map<String, dynamic> _$EliminationScoreTeamBodyToJson(
        EliminationScoreTeamBody instance) =>
    <String, dynamic>{
      'elimination_id': instance.elimination_id,
      'round': instance.round,
      'match': instance.match,
      'type': instance.type,
      'save_permanent': instance.save_permanent,
      'code': instance.code,
      'participants': instance.participants,
    };
