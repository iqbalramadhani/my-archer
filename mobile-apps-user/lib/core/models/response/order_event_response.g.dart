// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEventResponse _$OrderEventResponseFromJson(Map<String, dynamic> json) {
  return OrderEventResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataOrderEventModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderEventResponseToJson(OrderEventResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataOrderEventModel _$DataOrderEventModelFromJson(Map<String, dynamic> json) {
  return DataOrderEventModel()
    ..archeryEventParticipantsId = json['archeryEventParticipantsId'] as int?
    ..paymentInfo = json['paymentInfo'] == null
        ? null
        : PaymentInfoModel.fromJson(
            json['paymentInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DataOrderEventModelToJson(
        DataOrderEventModel instance) =>
    <String, dynamic>{
      'archeryEventParticipantsId': instance.archeryEventParticipantsId,
      'paymentInfo': instance.paymentInfo,
    };
