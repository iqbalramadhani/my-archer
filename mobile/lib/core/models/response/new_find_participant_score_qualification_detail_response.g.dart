// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_find_participant_score_qualification_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewFindParticipantScoreQualificationDetailResponse
    _$NewFindParticipantScoreQualificationDetailResponseFromJson(
            Map<String, dynamic> json) =>
        NewFindParticipantScoreQualificationDetailResponse()
          ..message = json['message'] as String?
          ..errors = json['errors']
          ..data = (json['data'] as List<dynamic>?)
              ?.map((e) => DataFindParticipantScoreDetailModel.fromJson(
                  e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$NewFindParticipantScoreQualificationDetailResponseToJson(
        NewFindParticipantScoreQualificationDetailResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
