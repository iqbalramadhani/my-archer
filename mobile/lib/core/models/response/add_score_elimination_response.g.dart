// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_score_elimination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddScoreEliminationResponse _$AddScoreEliminationResponseFromJson(
        Map<String, dynamic> json) =>
    AddScoreEliminationResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = json['data'] as bool?;

Map<String, dynamic> _$AddScoreEliminationResponseToJson(
        AddScoreEliminationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
