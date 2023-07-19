// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubResponse _$ClubResponseFromJson(Map<String, dynamic> json) {
  return ClubResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => ClubModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ClubResponseToJson(ClubResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
