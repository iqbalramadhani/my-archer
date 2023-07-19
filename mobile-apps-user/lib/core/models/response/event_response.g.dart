// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) {
  return EventResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
