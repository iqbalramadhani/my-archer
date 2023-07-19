// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionInfoModel _$TransactionInfoModelFromJson(Map<String, dynamic> json) {
  return TransactionInfoModel(
    orderId: json['orderId'] as String?,
    total: json['total'] as int?,
    statusId: json['statusId'] as int?,
    status: json['status'] as String?,
    transactionLogId: json['transactionLogId'] as int?,
    snapToken: json['snapToken'] as String?,
    clientKey: json['clientKey'] as String?,
    clientLibLink: json['clientLibLink'] as String?,
    orderDate: json['orderDate'] == null
        ? null
        : OrderDateModel.fromJson(json['orderDate'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransactionInfoModelToJson(
        TransactionInfoModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'total': instance.total,
      'statusId': instance.statusId,
      'status': instance.status,
      'transactionLogId': instance.transactionLogId,
      'snapToken': instance.snapToken,
      'clientKey': instance.clientKey,
      'clientLibLink': instance.clientLibLink,
      'orderDate': instance.orderDate,
    };

OrderDateModel _$OrderDateModelFromJson(Map<String, dynamic> json) {
  return OrderDateModel(
    date: json['date'] as String?,
  );
}

Map<String, dynamic> _$OrderDateModelToJson(OrderDateModel instance) =>
    <String, dynamic>{
      'date': instance.date,
    };
