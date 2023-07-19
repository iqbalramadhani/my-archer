import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/core/models/responses/base_response.dart';

part 'operational_time_response.g.dart';

@JsonSerializable()
class OperationalTimeResponse extends BaseResponse {
  List<TimeOperationalModel>? data;

  OperationalTimeResponse();

  factory OperationalTimeResponse.fromJson(Map<String, dynamic> json) =>
      _$OperationalTimeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OperationalTimeResponseToJson(this);
}
