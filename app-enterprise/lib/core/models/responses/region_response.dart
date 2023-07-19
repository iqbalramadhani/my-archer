

import 'package:json_annotation/json_annotation.dart';

import '../objects/region_model.dart';
import 'base_response.dart';

part 'region_response.g.dart';

@JsonSerializable()
class RegionResponse extends BaseResponse {
  List<RegionModel>? data;

  RegionResponse();

  factory RegionResponse.fromJson(Map<String, dynamic> json) =>
      _$RegionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegionResponseToJson(this);
}