

import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

import 'detail_event_response.dart';

part 'list_myevent_response.g.dart';

@JsonSerializable()
class ListMyeventResponse extends BaseResponse {

  List<DataDetailEventModel>? data;

  ListMyeventResponse();

  factory ListMyeventResponse.fromJson(Map<String, dynamic> json) =>
      _$ListMyeventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListMyeventResponseToJson(this);
}
