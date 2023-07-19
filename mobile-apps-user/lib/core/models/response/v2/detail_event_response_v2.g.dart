// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_event_response_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailEventResponseV2 _$DetailEventResponseV2FromJson(
    Map<String, dynamic> json) {
  return DetailEventResponseV2()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataDetailEventModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DetailEventResponseV2ToJson(
        DetailEventResponseV2 instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataDetailEventModel _$DataDetailEventModelFromJson(Map<String, dynamic> json) {
  return DataDetailEventModel(
    id: json['id'] as int?,
    poster: json['poster'] as String?,
    handbook: json['handbook'] as String?,
    eventName: json['eventName'] as String?,
    registrationStartDatetime: json['registrationStartDatetime'] as String?,
    registrationEndDatetime: json['registrationEndDatetime'] as String?,
    eventStartDatetime: json['eventStartDatetime'] as String?,
    eventEndDatetime: json['eventEndDatetime'] as String?,
    location: json['location'] as String?,
    locationType: json['locationType'] as String?,
    description: json['description'] as String?,
    adminId: json['adminId'] as int?,
    eventSlug: json['eventSlug'] as String?,
    eventCompetition: json['eventCompetition'] as String?,
    cityId: json['cityId'] as int?,
    status: json['status'] as int?,
    eventType: json['eventType'] as String?,
    needVerify: json['needVerify'] as int?,
    detailAdmin: json['detailAdmin'] == null
        ? null
        : ProfileModel.fromJson(json['detailAdmin'] as Map<String, dynamic>),
    detailCity: json['detailCity'] == null
        ? null
        : CityModel.fromJson(json['detailCity'] as Map<String, dynamic>),
    eventStatus: json['eventStatus'] as String?,
    moreInformation: (json['moreInformation'] as List<dynamic>?)
        ?.map((e) => EventMoreInfoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    eventPrice: json['eventPrice'],
  )
    ..message = json['message'] as String?
    ..errors = json['errors'];
}

Map<String, dynamic> _$DataDetailEventModelToJson(
        DataDetailEventModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'poster': instance.poster,
      'handbook': instance.handbook,
      'eventName': instance.eventName,
      'registrationStartDatetime': instance.registrationStartDatetime,
      'registrationEndDatetime': instance.registrationEndDatetime,
      'eventStartDatetime': instance.eventStartDatetime,
      'eventEndDatetime': instance.eventEndDatetime,
      'location': instance.location,
      'locationType': instance.locationType,
      'description': instance.description,
      'adminId': instance.adminId,
      'eventSlug': instance.eventSlug,
      'eventCompetition': instance.eventCompetition,
      'cityId': instance.cityId,
      'status': instance.status,
      'eventType': instance.eventType,
      'needVerify': instance.needVerify,
      'detailAdmin': instance.detailAdmin,
      'detailCity': instance.detailCity,
      'eventStatus': instance.eventStatus,
      'moreInformation': instance.moreInformation,
      'eventPrice': instance.eventPrice,
    };
