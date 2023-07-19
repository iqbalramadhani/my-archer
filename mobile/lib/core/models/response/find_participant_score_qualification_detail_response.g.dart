// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_participant_score_qualification_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindParticipantScoreQualificationDetailResponse
    _$FindParticipantScoreQualificationDetailResponseFromJson(
            Map<String, dynamic> json) =>
        FindParticipantScoreQualificationDetailResponse()
          ..message = json['message'] as String?
          ..errors = json['errors']
          ..data = json['data'] == null
              ? null
              : DataFindParticipantScoreDetailModel.fromJson(
                  json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$FindParticipantScoreQualificationDetailResponseToJson(
        FindParticipantScoreQualificationDetailResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataFindParticipantScoreDetailModel
    _$DataFindParticipantScoreDetailModelFromJson(Map<String, dynamic> json) =>
        DataFindParticipantScoreDetailModel(
          participant: json['participant'] == null
              ? null
              : ParticipantModel.fromJson(
                  json['participant'] as Map<String, dynamic>),
          score: json['score'] == null
              ? null
              : ScoreModel.fromJson(json['score'] as Map<String, dynamic>),
          budrestNumber: json['budrestNumber'] as String?,
          session: json['session'],
          isUpdated: json['isUpdated'] as int?,
        )..scheduleId = json['scheduleId'] as int?;

Map<String, dynamic> _$DataFindParticipantScoreDetailModelToJson(
        DataFindParticipantScoreDetailModel instance) =>
    <String, dynamic>{
      'participant': instance.participant,
      'score': instance.score,
      'budrestNumber': instance.budrestNumber,
      'session': instance.session,
      'scheduleId': instance.scheduleId,
      'isUpdated': instance.isUpdated,
    };
