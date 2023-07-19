// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_elimination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedEliminationModel _$SavedEliminationModelFromJson(
        Map<String, dynamic> json) =>
    SavedEliminationModel(
      json['bantalan'] as String?,
      json['code'] as String?,
      json['data'] == null
          ? null
          : FindParticipantScoreEliminationDetailResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SavedEliminationModelToJson(
        SavedEliminationModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'bantalan': instance.bantalan,
      'data': instance.data,
    };
