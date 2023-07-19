

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/core/models/responses/base_response.dart';

part 'detail_venue_response.g.dart';

@JsonSerializable()
class DetailVenueResponse extends BaseResponse {
  VenueModel? data;

  DetailVenueResponse();

  factory DetailVenueResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailVenueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailVenueResponseToJson(this);
}
