// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberClubModel _$MemberClubModelFromJson(Map<String, dynamic> json) {
  return MemberClubModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phoneNumber'],
    avatar: json['avatar'] as String?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    dateOfBirth: json['dateOfBirth'] as String?,
    gender: json['gender'] as String?,
    memberId: json['memberId'] as int?,
    isAdmin: json['isAdmin'] as int?,
    age: json['age'] as int?,
  );
}

Map<String, dynamic> _$MemberClubModelToJson(MemberClubModel instance) =>
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
      'memberId': instance.memberId,
      'isAdmin': instance.isAdmin,
      'age': instance.age,
    };
