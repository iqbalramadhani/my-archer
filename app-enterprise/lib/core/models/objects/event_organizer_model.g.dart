// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_organizer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventOrganizerModel _$EventOrganizerModelFromJson(Map<String, dynamic> json) =>
    EventOrganizerModel()
      ..id = json['id'] as int?
      ..eoName = json['eoName'] as String?
      ..createdAt = json['createdAt']
      ..updatedAt = json['updatedAt'];

Map<String, dynamic> _$EventOrganizerModelToJson(
        EventOrganizerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eoName': instance.eoName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
