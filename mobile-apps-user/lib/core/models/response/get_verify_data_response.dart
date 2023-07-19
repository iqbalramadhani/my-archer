

import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

part 'get_verify_data_response.g.dart';

@JsonSerializable()
class GetVerifyDataResponse extends BaseResponse {

  DataVerifyModel? data;

  GetVerifyDataResponse();

  factory GetVerifyDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetVerifyDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetVerifyDataResponseToJson(this);
}

@JsonSerializable()
class DataVerifyModel {
  dynamic userId;
  dynamic nik;
  String? ktpKk;
  String? selfieKtpKk;

  DataVerifyModel();

  factory DataVerifyModel.fromJson(Map<String, dynamic> json) =>
      _$DataVerifyModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataVerifyModelToJson(this);
}
