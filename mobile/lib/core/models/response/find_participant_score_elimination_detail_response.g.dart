// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_participant_score_elimination_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindParticipantScoreEliminationDetailResponse
    _$FindParticipantScoreEliminationDetailResponseFromJson(
            Map<String, dynamic> json) =>
        FindParticipantScoreEliminationDetailResponse()
          ..message = json['message'] as String?
          ..errors = json['errors']
          ..data = (json['data'] as List<dynamic>?)
              ?.map((e) => DataEliminationParticipantModel.fromJson(
                  e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$FindParticipantScoreEliminationDetailResponseToJson(
        FindParticipantScoreEliminationDetailResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataEliminationParticipantModel _$DataEliminationParticipantModelFromJson(
        Map<String, dynamic> json) =>
    DataEliminationParticipantModel()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..participant = json['participant'] == null
          ? null
          : ParticipantModel.fromJson(
              json['participant'] as Map<String, dynamic>)
      ..scores = json['scores'] == null
          ? null
          : ScoresEliminationModel.fromJson(
              json['scores'] as Map<String, dynamic>)
      ..session = json['session']
      ..isUpdated = json['isUpdated'] as int?
      ..round = json['round']
      ..budrestNumber = json['budrestNumber'] as String?
      ..teamDetail = json['teamDetail'] == null
          ? null
          : TeamDetailModel.fromJson(json['teamDetail'] as Map<String, dynamic>)
      ..listMember = (json['listMember'] as List<dynamic>?)
          ?.map((e) => ListMemberModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..category = json['category'] == null
          ? null
          : ParticipantModel.fromJson(json['category'] as Map<String, dynamic>);

Map<String, dynamic> _$DataEliminationParticipantModelToJson(
        DataEliminationParticipantModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'participant': instance.participant,
      'scores': instance.scores,
      'session': instance.session,
      'isUpdated': instance.isUpdated,
      'round': instance.round,
      'budrestNumber': instance.budrestNumber,
      'teamDetail': instance.teamDetail,
      'listMember': instance.listMember,
      'category': instance.category,
    };

ScoresEliminationModel _$ScoresEliminationModelFromJson(
        Map<String, dynamic> json) =>
    ScoresEliminationModel(
      shot: (json['shot'] as List<dynamic>?)
          ?.map((e) => ShotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      extraShot: (json['extraShot'] as List<dynamic>?)
          ?.map((e) => ExtraShotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      win: json['win'] as int?,
      total: json['total'] as int?,
      eliminationtScoreType: json['eliminationtScoreType'] as int?,
    )..result = json['result'] as int?;

Map<String, dynamic> _$ScoresEliminationModelToJson(
        ScoresEliminationModel instance) =>
    <String, dynamic>{
      'shot': instance.shot,
      'extraShot': instance.extraShot,
      'win': instance.win,
      'total': instance.total,
      'eliminationtScoreType': instance.eliminationtScoreType,
      'result': instance.result,
    };

ListMemberModel _$ListMemberModelFromJson(Map<String, dynamic> json) =>
    ListMemberModel()
      ..userId = json['userId']
      ..memberId = json['memberId']
      ..name = json['name'] as String?;

Map<String, dynamic> _$ListMemberModelToJson(ListMemberModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'memberId': instance.memberId,
      'name': instance.name,
    };
