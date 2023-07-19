// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_event_response_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEventResponseV2 _$CategoryEventResponseV2FromJson(
    Map<String, dynamic> json) {
  return CategoryEventResponseV2()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => CategoryModelV2.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CategoryEventResponseV2ToJson(
        CategoryEventResponseV2 instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
