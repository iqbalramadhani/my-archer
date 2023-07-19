// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueResponse _$VenueResponseFromJson(Map<String, dynamic> json) =>
    VenueResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => VenueModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$VenueResponseToJson(VenueResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
