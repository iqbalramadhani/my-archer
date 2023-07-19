

import 'package:json_annotation/json_annotation.dart';
import '../objects/payment_info_model.dart';
import 'base_response.dart';

part 'order_official_response.g.dart';

@JsonSerializable()
class OrderOfficialResponse extends BaseResponse {
  DataOrderOfficialModel? data;

  OrderOfficialResponse();

  factory OrderOfficialResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderOfficialResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderOfficialResponseToJson(this);
}

@JsonSerializable()
class DataOrderOfficialModel {
  PaymentInfoModel? paymentInfo;

  DataOrderOfficialModel();

  factory DataOrderOfficialModel.fromJson(Map<String, dynamic> json) =>
      _$DataOrderOfficialModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataOrderOfficialModelToJson(this);
}
