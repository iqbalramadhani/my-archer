// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPaginationResponse _$EventPaginationResponseFromJson(
    Map<String, dynamic> json) {
  return EventPaginationResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventPaginationResponseToJson(
        EventPaginationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel()
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..totalPage = json['totalPage'] as int?;
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'data': instance.data,
      'totalPage': instance.totalPage,
    };
