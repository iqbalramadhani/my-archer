

import 'package:json_annotation/json_annotation.dart';
import '../objects/club_model.dart';
import 'base_response.dart';

part 'my_club_response.g.dart';

@JsonSerializable()
class MyClubResponse extends BaseResponse {
  List<DetailClubModel>? data;
  MyClubResponse();

  factory MyClubResponse.fromJson(Map<String, dynamic> json) =>
      _$MyClubResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyClubResponseToJson(this);
}