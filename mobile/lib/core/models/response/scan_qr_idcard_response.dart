

import 'package:json_annotation/json_annotation.dart';

import 'response.dart';

part 'scan_qr_idcard_response.g.dart';

@JsonSerializable()
class ScanQrIdcardResponse extends BaseResponse {

  DataScanQrIdcardModel? data;

  ScanQrIdcardResponse();

  factory ScanQrIdcardResponse.fromJson(Map<String, dynamic> json) =>
      _$ScanQrIdcardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScanQrIdcardResponseToJson(this);
}

@JsonSerializable()
class DataScanQrIdcardModel extends BaseResponse {

  String? base64HtmlTemplate;
 
  DataScanQrIdcardModel();

  factory DataScanQrIdcardModel.fromJson(Map<String, dynamic> json) =>
      _$DataScanQrIdcardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataScanQrIdcardModelToJson(this);
}
