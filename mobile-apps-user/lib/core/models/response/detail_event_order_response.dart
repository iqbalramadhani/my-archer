

import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
import 'event_order_response.dart';

part 'detail_event_order_response.g.dart';

@JsonSerializable()
class DetailEventOrderResponse extends BaseResponse {
  DataModel? data;

  DetailEventOrderResponse();

  factory DetailEventOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailEventOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailEventOrderResponseToJson(this);
}
