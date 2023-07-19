// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_score_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveScoreResponse _$SaveScoreResponseFromJson(Map<String, dynamic> json) =>
    SaveScoreResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = json['data'] == null
          ? null
          : DataSaveScoreModel.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$SaveScoreResponseToJson(SaveScoreResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataSaveScoreModel _$DataSaveScoreModelFromJson(Map<String, dynamic> json) =>
    DataSaveScoreModel()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..id = json['id'] as int?
      ..participantMemberId = json['participantMemberId']
      ..total = json['total'] as int?
      ..scoringSession = json['scoringSession']
      ..scoringDetail = json['scoringDetail'] as String?
      ..type = json['type']
      ..scoringLog = json['scoringLog'] as String?
      ..createdAt = json['createdAt'] as String?
      ..updatedAt = json['updatedAt'] as String?;

Map<String, dynamic> _$DataSaveScoreModelToJson(DataSaveScoreModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'participantMemberId': instance.participantMemberId,
      'total': instance.total,
      'scoringSession': instance.scoringSession,
      'scoringDetail': instance.scoringDetail,
      'type': instance.type,
      'scoringLog': instance.scoringLog,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
