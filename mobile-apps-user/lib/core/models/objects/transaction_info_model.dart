

import 'package:json_annotation/json_annotation.dart';

part 'transaction_info_model.g.dart';

@JsonSerializable()
class TransactionInfoModel {
  // ProfileModel? profile;
  String? orderId;
  int? total;
  int? statusId;
  String? status;
  int? transactionLogId;
  String? snapToken;
  String? clientKey;
  String? clientLibLink;
  OrderDateModel? orderDate;


  TransactionInfoModel(
      {this.orderId,
      this.total,
      this.statusId,
      this.status,
      this.transactionLogId,
      this.snapToken,
      this.clientKey,
      this.clientLibLink,
      this.orderDate});

  factory TransactionInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionInfoModelToJson(this);
}

@JsonSerializable()
class OrderDateModel {
  String? date;


  OrderDateModel({this.date});

  factory OrderDateModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDateModelToJson(this);
}
