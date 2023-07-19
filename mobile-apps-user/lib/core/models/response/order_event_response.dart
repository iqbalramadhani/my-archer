

import 'package:json_annotation/json_annotation.dart';
import '../objects/payment_info_model.dart';
import 'base_response.dart';

part 'order_event_response.g.dart';

@JsonSerializable()
class OrderEventResponse extends BaseResponse {
  DataOrderEventModel? data;

  OrderEventResponse();

  factory OrderEventResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEventResponseToJson(this);
}

@JsonSerializable()
class DataOrderEventModel {
  int? archeryEventParticipantsId;
  PaymentInfoModel? paymentInfo;

  DataOrderEventModel();

  factory DataOrderEventModel.fromJson(Map<String, dynamic> json) =>
      _$DataOrderEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataOrderEventModelToJson(this);
}
