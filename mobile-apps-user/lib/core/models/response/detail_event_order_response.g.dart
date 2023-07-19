// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_event_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailEventOrderResponse _$DetailEventOrderResponseFromJson(
    Map<String, dynamic> json) {
  return DetailEventOrderResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DetailEventOrderResponseToJson(
        DetailEventOrderResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
