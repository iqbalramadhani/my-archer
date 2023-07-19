

import 'package:json_annotation/json_annotation.dart';
import '../objects/event_model.dart';
import 'base_response.dart';

part 'event_pagination_response.g.dart';

@JsonSerializable()
class EventPaginationResponse extends BaseResponse {
  DataModel? data;

  EventPaginationResponse();

  factory EventPaginationResponse.fromJson(Map<String, dynamic> json) =>
      _$EventPaginationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventPaginationResponseToJson(this);
}

@JsonSerializable()
class DataModel{
  List<EventModel>? data;
  int? totalPage;

  DataModel();

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
