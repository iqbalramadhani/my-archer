// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_verify_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVerifyDataResponse _$GetVerifyDataResponseFromJson(
    Map<String, dynamic> json) {
  return GetVerifyDataResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataVerifyModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetVerifyDataResponseToJson(
        GetVerifyDataResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataVerifyModel _$DataVerifyModelFromJson(Map<String, dynamic> json) {
  return DataVerifyModel()
    ..userId = json['userId']
    ..nik = json['nik']
    ..ktpKk = json['ktpKk'] as String?
    ..selfieKtpKk = json['selfieKtpKk'] as String?;
}

Map<String, dynamic> _$DataVerifyModelToJson(DataVerifyModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nik': instance.nik,
      'ktpKk': instance.ktpKk,
      'selfieKtpKk': instance.selfieKtpKk,
    };
