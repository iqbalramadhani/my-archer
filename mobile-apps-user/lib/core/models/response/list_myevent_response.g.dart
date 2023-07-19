// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_myevent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMyeventResponse _$ListMyeventResponseFromJson(Map<String, dynamic> json) {
  return ListMyeventResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => DataDetailEventModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ListMyeventResponseToJson(
        ListMyeventResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
