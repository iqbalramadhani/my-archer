// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInfoModel _$PaymentInfoModelFromJson(Map<String, dynamic> json) {
  return PaymentInfoModel()
    ..clientKey = json['clientKey'] as String?
    ..clientLibLink = json['clientLibLink'] as String?
    ..orderId = json['orderId'] as String?
    ..snapToken = json['snapToken'] as String?
    ..status = json['status'] as String?
    ..total = json['total'] as int?
    ..transactionLogId = json['transactionLogId'] as int?;
}

Map<String, dynamic> _$PaymentInfoModelToJson(PaymentInfoModel instance) =>
    <String, dynamic>{
      'clientKey': instance.clientKey,
      'clientLibLink': instance.clientLibLink,
      'orderId': instance.orderId,
      'snapToken': instance.snapToken,
      'status': instance.status,
      'total': instance.total,
      'transactionLogId': instance.transactionLogId,
    };
