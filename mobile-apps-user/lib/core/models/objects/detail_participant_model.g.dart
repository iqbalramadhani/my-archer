// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailParticipantModel _$DetailParticipantModelFromJson(
    Map<String, dynamic> json) {
  return DetailParticipantModel()
    ..idParticipant = json['idParticipant'] as int?
    ..userId = json['userId'] as int?
    ..email = json['email'] as String?
    ..phoneNumber = json['phoneNumber']
    ..age = json['age'] as int?
    ..gender = json['gender'] as String?
    ..status = json['status'] as int?
    ..teamName = json['teamName'] as String?
    ..orderId = json['orderId'] as String?
    ..clubDetail = (json['clubDetail'] as List<dynamic>?)
        ?.map((e) => DetailClubModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..historyQualification = json['historyQualification'] as String?;
}

Map<String, dynamic> _$DetailParticipantModelToJson(
        DetailParticipantModel instance) =>
    <String, dynamic>{
      'idParticipant': instance.idParticipant,
      'userId': instance.userId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'age': instance.age,
      'gender': instance.gender,
      'status': instance.status,
      'teamName': instance.teamName,
      'orderId': instance.orderId,
      'clubDetail': instance.clubDetail,
      'historyQualification': instance.historyQualification,
    };
