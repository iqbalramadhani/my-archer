// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_more_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventMoreInfoModel _$EventMoreInfoModelFromJson(Map<String, dynamic> json) {
  return EventMoreInfoModel()
    ..id = json['id'] as int?
    ..eventId = json['eventId'] as int?
    ..title = json['title'] as String?
    ..description = json['description'] as String?;
}

Map<String, dynamic> _$EventMoreInfoModelToJson(EventMoreInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'title': instance.title,
      'description': instance.description,
    };
