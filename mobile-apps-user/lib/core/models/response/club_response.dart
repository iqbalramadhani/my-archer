

import 'package:json_annotation/json_annotation.dart';

import '../objects/club_model.dart';
import 'base_response.dart';

part 'club_response.g.dart';

@JsonSerializable()
class ClubResponse extends BaseResponse {
  List<ClubModel>? data;

  ClubResponse();

  factory ClubResponse.fromJson(Map<String, dynamic> json) =>
      _$ClubResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClubResponseToJson(this);
}
