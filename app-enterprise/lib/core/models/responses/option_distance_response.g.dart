// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_distance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionDistanceResponse _$OptionDistanceResponseFromJson(
        Map<String, dynamic> json) =>
    OptionDistanceResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => OptionDistanceModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$OptionDistanceResponseToJson(
        OptionDistanceResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
