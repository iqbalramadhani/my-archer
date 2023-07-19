

import 'package:json_annotation/json_annotation.dart';

import '../objects/club_model.dart';
import 'base_response.dart';

part 'detail_club_response.g.dart';

@JsonSerializable()
class DetailClubResponse extends BaseResponse {
  DetailClubModel? data;

  DetailClubResponse();

  factory DetailClubResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailClubResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailClubResponseToJson(this);
}
