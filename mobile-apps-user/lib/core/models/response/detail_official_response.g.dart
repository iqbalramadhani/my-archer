// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_official_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailOfficialResponse _$DetailOfficialResponseFromJson(
    Map<String, dynamic> json) {
  return DetailOfficialResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataDetailOfficialModel.fromJson(
            json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DetailOfficialResponseToJson(
        DetailOfficialResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataDetailOfficialModel _$DataDetailOfficialModelFromJson(
    Map<String, dynamic> json) {
  return DataDetailOfficialModel()
    ..eventOfficialDetail = json['eventOfficialDetail'] == null
        ? null
        : EventOfficialDetailModel.fromJson(
            json['eventOfficialDetail'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DataDetailOfficialModelToJson(
        DataDetailOfficialModel instance) =>
    <String, dynamic>{
      'eventOfficialDetail': instance.eventOfficialDetail,
    };

EventOfficialDetailModel _$EventOfficialDetailModelFromJson(
    Map<String, dynamic> json) {
  return EventOfficialDetailModel()
    ..eventOfficialDetailId = json['eventOfficialDetailId']
    ..quota = json['quota']
    ..fee = json['fee'] as String?;
}

Map<String, dynamic> _$EventOfficialDetailModelToJson(
        EventOfficialDetailModel instance) =>
    <String, dynamic>{
      'eventOfficialDetailId': instance.eventOfficialDetailId,
      'quota': instance.quota,
      'fee': instance.fee,
    };
