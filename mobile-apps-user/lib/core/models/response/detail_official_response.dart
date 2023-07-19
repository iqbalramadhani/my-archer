import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

part 'detail_official_response.g.dart';

@JsonSerializable()
class DetailOfficialResponse extends BaseResponse {
  DataDetailOfficialModel? data;

  DetailOfficialResponse();

  factory DetailOfficialResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailOfficialResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailOfficialResponseToJson(this);
}

@JsonSerializable()
class DataDetailOfficialModel {
  EventOfficialDetailModel? eventOfficialDetail;

  DataDetailOfficialModel();

  factory DataDetailOfficialModel.fromJson(Map<String, dynamic> json) =>
      _$DataDetailOfficialModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailOfficialModelToJson(this);
}

@JsonSerializable()
class EventOfficialDetailModel {
  dynamic eventOfficialDetailId;
  dynamic quota;
  String? fee;

  EventOfficialDetailModel();

  factory EventOfficialDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EventOfficialDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventOfficialDetailModelToJson(this);
}
