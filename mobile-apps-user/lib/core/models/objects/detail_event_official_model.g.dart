// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_event_official_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailEventOfficialModel _$DetailEventOfficialModelFromJson(
    Map<String, dynamic> json) {
  return DetailEventOfficialModel()
    ..eventOfficialId = json['eventOfficialId'] as int?
    ..type = json['type'] as int?
    ..relationWithParticipant = json['relationWithParticipant'] as int?
    ..relationWithParticipantLabel =
        json['relationWithParticipantLabel'] as String?
    ..status = json['status'] as int?
    ..statusLabel = json['statusLabel'] as String?
    ..teamCategoryId = json['teamCategoryId'] as String?
    ..categoryLabel = json['categoryLabel'] as String?;
}

Map<String, dynamic> _$DetailEventOfficialModelToJson(
        DetailEventOfficialModel instance) =>
    <String, dynamic>{
      'eventOfficialId': instance.eventOfficialId,
      'type': instance.type,
      'relationWithParticipant': instance.relationWithParticipant,
      'relationWithParticipantLabel': instance.relationWithParticipantLabel,
      'status': instance.status,
      'statusLabel': instance.statusLabel,
      'teamCategoryId': instance.teamCategoryId,
      'categoryLabel': instance.categoryLabel,
    };
