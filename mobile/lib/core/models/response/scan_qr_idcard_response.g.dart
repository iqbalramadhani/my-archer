// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_qr_idcard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanQrIdcardResponse _$ScanQrIdcardResponseFromJson(
        Map<String, dynamic> json) =>
    ScanQrIdcardResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = json['data'] == null
          ? null
          : DataScanQrIdcardModel.fromJson(
              json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$ScanQrIdcardResponseToJson(
        ScanQrIdcardResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataScanQrIdcardModel _$DataScanQrIdcardModelFromJson(
        Map<String, dynamic> json) =>
    DataScanQrIdcardModel()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..base64HtmlTemplate = json['base64HtmlTemplate'] as String?;

Map<String, dynamic> _$DataScanQrIdcardModelToJson(
        DataScanQrIdcardModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'base64HtmlTemplate': instance.base64HtmlTemplate,
    };
