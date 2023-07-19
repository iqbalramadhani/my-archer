

import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'base_response_data.g.dart';

@JsonSerializable()
class BaseResponseData extends BaseResponse {
  dynamic data;

  BaseResponseData();

  factory BaseResponseData.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseDataToJson(this);
}
