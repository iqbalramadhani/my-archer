

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/option_distance_model.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/core/models/responses/base_response.dart';

part 'option_distance_response.g.dart';

@JsonSerializable()
class OptionDistanceResponse extends BaseResponse {
  List<OptionDistanceModel>? data;

  OptionDistanceResponse();

  factory OptionDistanceResponse.fromJson(Map<String, dynamic> json) =>
      _$OptionDistanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OptionDistanceResponseToJson(this);
}
