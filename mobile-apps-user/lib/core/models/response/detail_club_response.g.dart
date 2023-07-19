// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_club_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailClubResponse _$DetailClubResponseFromJson(Map<String, dynamic> json) {
  return DetailClubResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DetailClubModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DetailClubResponseToJson(DetailClubResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
