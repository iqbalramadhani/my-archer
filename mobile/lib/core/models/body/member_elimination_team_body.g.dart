// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_elimination_team_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEliminationTeamBody _$MemberEliminationTeamBodyFromJson(
        Map<String, dynamic> json) =>
    MemberEliminationTeamBody(
      participant_id: json['participant_id'] as int?,
      scores: json['scores'] == null
          ? null
          : ScoresEliminationModel.fromJson(
              json['scores'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberEliminationTeamBodyToJson(
        MemberEliminationTeamBody instance) =>
    <String, dynamic>{
      'participant_id': instance.participant_id,
      'scores': instance.scores,
    };
