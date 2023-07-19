// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_club_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyClubResponse _$MyClubResponseFromJson(Map<String, dynamic> json) {
  return MyClubResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => DetailClubModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MyClubResponseToJson(MyClubResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
