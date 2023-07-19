

import 'package:json_annotation/json_annotation.dart';

import '../objects/event_model.dart';
import '../objects/participant_model.dart';
import '../objects/transaction_info_model.dart';
import 'base_response.dart';

part 'event_order_response.g.dart';

@JsonSerializable()
class EventOrderResponse extends BaseResponse {
  List<DataModel>? data;

  EventOrderResponse();

  factory EventOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$EventOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventOrderResponseToJson(this);
}

@JsonSerializable()
class DataModel{
  EventModel? archeryEvent;
  ParticipantModel? participant;
  TransactionInfoModel? transactionInfo;

  DataModel();

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
