// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_venue_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailVenueResponse _$DetailVenueResponseFromJson(Map<String, dynamic> json) =>
    DetailVenueResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = json['data'] == null
          ? null
          : VenueModel.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$DetailVenueResponseToJson(
        DetailVenueResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
