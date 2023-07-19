// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataLoginModel _$DataLoginModelFromJson(Map<String, dynamic> json) {
  return DataLoginModel()
    ..accessToken = json['accessToken'] as String?
    ..tokenType = json['tokenType'] as String?
    ..expiresIn = json['expiresIn'];
}

Map<String, dynamic> _$DataLoginModelToJson(DataLoginModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
    };
