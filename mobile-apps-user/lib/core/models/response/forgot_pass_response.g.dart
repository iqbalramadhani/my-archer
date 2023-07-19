// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_pass_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPassResponse _$ForgotPassResponseFromJson(Map<String, dynamic> json) {
  return ForgotPassResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'];
}

Map<String, dynamic> _$ForgotPassResponseToJson(ForgotPassResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
