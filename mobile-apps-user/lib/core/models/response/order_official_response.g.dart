// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_official_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderOfficialResponse _$OrderOfficialResponseFromJson(
    Map<String, dynamic> json) {
  return OrderOfficialResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataOrderOfficialModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderOfficialResponseToJson(
        OrderOfficialResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataOrderOfficialModel _$DataOrderOfficialModelFromJson(
    Map<String, dynamic> json) {
  return DataOrderOfficialModel()
    ..paymentInfo = json['paymentInfo'] == null
        ? null
        : PaymentInfoModel.fromJson(
            json['paymentInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DataOrderOfficialModelToJson(
        DataOrderOfficialModel instance) =>
    <String, dynamic>{
      'paymentInfo': instance.paymentInfo,
    };
