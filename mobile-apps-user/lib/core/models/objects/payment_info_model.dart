

import 'package:json_annotation/json_annotation.dart';

part 'payment_info_model.g.dart';

@JsonSerializable()
class PaymentInfoModel {
  String? clientKey;
  String? clientLibLink;
  String? orderId;
  String? snapToken;
  String? status;
  int? total;
  int? transactionLogId;

  PaymentInfoModel();

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoModelToJson(this);
}
