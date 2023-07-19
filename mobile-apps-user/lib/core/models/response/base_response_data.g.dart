// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseData _$BaseResponseDataFromJson(Map<String, dynamic> json) {
  return BaseResponseData()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'];
}

Map<String, dynamic> _$BaseResponseDataToJson(BaseResponseData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
