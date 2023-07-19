// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_scoresheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedScoresheetModel _$SavedScoresheetModelFromJson(
        Map<String, dynamic> json) =>
    SavedScoresheetModel(
      json['bantalan'] as String?,
      json['schedulId'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => DataFindParticipantScoreDetailModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SavedScoresheetModelToJson(
        SavedScoresheetModel instance) =>
    <String, dynamic>{
      'schedulId': instance.schedulId,
      'bantalan': instance.bantalan,
      'data': instance.data,
    };
