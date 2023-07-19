// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_email_event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckEmailEventResponse _$CheckEmailEventResponseFromJson(
    Map<String, dynamic> json) {
  return CheckEmailEventResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => ParticipantModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CheckEmailEventResponseToJson(
        CheckEmailEventResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
