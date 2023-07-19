// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_my_event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailMyEventResponse _$DetailMyEventResponseFromJson(
    Map<String, dynamic> json) {
  return DetailMyEventResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataDetailMyEvent.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DetailMyEventResponseToJson(
        DetailMyEventResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataDetailMyEvent _$DataDetailMyEventFromJson(Map<String, dynamic> json) {
  return DataDetailMyEvent()
    ..eventDetail = json['eventDetail'] == null
        ? null
        : DataDetailEventModel.fromJson(
            json['eventDetail'] as Map<String, dynamic>)
    ..categoryDetail = (json['categoryDetail'] as List<dynamic>?)
        ?.map((e) => CategoryDetailModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DataDetailMyEventToJson(DataDetailMyEvent instance) =>
    <String, dynamic>{
      'eventDetail': instance.eventDetail,
      'categoryDetail': instance.categoryDetail,
    };
