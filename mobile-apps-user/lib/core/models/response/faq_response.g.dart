// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqResponse _$FaqResponseFromJson(Map<String, dynamic> json) {
  return FaqResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FaqResponseToJson(FaqResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
