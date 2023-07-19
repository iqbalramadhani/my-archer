// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionResponse _$RegionResponseFromJson(Map<String, dynamic> json) =>
    RegionResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => RegionModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RegionResponseToJson(RegionResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
