

import 'package:json_annotation/json_annotation.dart';

import '../objects/category_detail_model.dart';
import 'base_response.dart';
import 'detail_event_response.dart';

part 'detail_my_event_response.g.dart';

@JsonSerializable()
class DetailMyEventResponse extends BaseResponse {
  DataDetailMyEvent? data;

  DetailMyEventResponse();

  factory DetailMyEventResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailMyEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailMyEventResponseToJson(this);
}


@JsonSerializable()
class DataDetailMyEvent{
  DataDetailEventModel? eventDetail;
  List<CategoryDetailModel>? categoryDetail;


  DataDetailMyEvent();

  factory DataDetailMyEvent.fromJson(Map<String, dynamic> json) =>
      _$DataDetailMyEventFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailMyEventToJson(this);
}
