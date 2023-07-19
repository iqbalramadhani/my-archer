// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operational_time_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationalTimeResponse _$OperationalTimeResponseFromJson(
        Map<String, dynamic> json) =>
    OperationalTimeResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => TimeOperationalModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$OperationalTimeResponseToJson(
        OperationalTimeResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
