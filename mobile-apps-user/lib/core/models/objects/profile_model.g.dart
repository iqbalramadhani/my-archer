// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phoneNumber'],
    avatar: json['avatar'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    dateOfBirth: json['dateOfBirth'] as String?,
    placeOfBirth: json['placeOfBirth'] as String?,
    gender: json['gender'] as String?,
    age: json['age'] as int?,
    eoId: json['eoId'] as int?,
  )
    ..nik = json['nik']
    ..address = json['address'] as String?
    ..addressProvinceId = json['addressProvinceId']
    ..addressCityId = json['addressCityId']
    ..verifyStatus = json['verifyStatus'] as int?
    ..dateVerified = json['dateVerified'] as String?
    ..reasonRejected = json['reasonRejected'] as String?
    ..selfieKtpKk = json['selfieKtpKk'] as String?
    ..ktpKk = json['ktpKk'] as String?
    ..statusVerify = json['statusVerify'] as String?;
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'nik': instance.nik,
      'address': instance.address,
      'placeOfBirth': instance.placeOfBirth,
      'addressProvinceId': instance.addressProvinceId,
      'addressCityId': instance.addressCityId,
      'verifyStatus': instance.verifyStatus,
      'dateVerified': instance.dateVerified,
      'reasonRejected': instance.reasonRejected,
      'selfieKtpKk': instance.selfieKtpKk,
      'ktpKk': instance.ktpKk,
      'age': instance.age,
      'eoId': instance.eoId,
      'statusVerify': instance.statusVerify,
    };
