// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_elimination_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEliminationBody _$MemberEliminationBodyFromJson(
        Map<String, dynamic> json) =>
    MemberEliminationBody(
      member_id: json['member_id'] as int?,
      scores: json['scores'] == null
          ? null
          : ScoresEliminationModel.fromJson(
              json['scores'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberEliminationBodyToJson(
        MemberEliminationBody instance) =>
    <String, dynamic>{
      'member_id': instance.member_id,
      'scores': instance.scores,
    };
