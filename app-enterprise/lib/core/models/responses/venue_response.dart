

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/core/models/responses/base_response.dart';

part 'venue_response.g.dart';

@JsonSerializable()
class VenueResponse extends BaseResponse {
  List<VenueModel>? data;

  VenueResponse();

  factory VenueResponse.fromJson(Map<String, dynamic> json) =>
      _$VenueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VenueResponseToJson(this);
}
