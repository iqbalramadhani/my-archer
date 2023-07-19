

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/core/models/responses/base_response.dart';

part 'facility_response.g.dart';

@JsonSerializable()
class FacilityResponse extends BaseResponse {
  List<FacilityModel>? data;

  FacilityResponse();

  factory FacilityResponse.fromJson(Map<String, dynamic> json) =>
      _$FacilityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityResponseToJson(this);
}
