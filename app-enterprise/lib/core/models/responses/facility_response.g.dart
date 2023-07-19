// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityResponse _$FacilityResponseFromJson(Map<String, dynamic> json) =>
    FacilityResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => FacilityModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FacilityResponseToJson(FacilityResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
