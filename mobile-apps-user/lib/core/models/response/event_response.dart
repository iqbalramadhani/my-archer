

import 'package:json_annotation/json_annotation.dart';
import '../objects/event_model.dart';
import 'base_response.dart';

part 'event_response.g.dart';

@JsonSerializable()
class EventResponse extends BaseResponse {
  List<EventModel>? data;

  EventResponse();

  factory EventResponse.fromJson(Map<String, dynamic> json) =>
      _$EventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseToJson(this);
}
