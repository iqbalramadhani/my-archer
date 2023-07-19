// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return EventModel()
    ..id = json['id'] as int?
    ..poster = json['poster'] as String?
    ..handbook = json['handbook'] as String?
    ..eventName = json['eventName'] as String?
    ..registrationStartDatetime = json['registrationStartDatetime'] as String?
    ..registrationEndDatetime = json['registrationEndDatetime'] as String?
    ..eventStartDatetime = json['eventStartDatetime'] as String?
    ..eventEndDatetime = json['eventEndDatetime'] as String?
    ..location = json['location'] as String?
    ..locationType = json['locationType'] as String?
    ..description = json['description'] as String?
    ..isFlatRegistrationFee = json['isFlatRegistrationFee'] as bool?
    ..publishedDatetime = json['publishedDatetime'] as String?
    ..createdAt = json['createdAt'] as String?
    ..updatedAt = json['updatedAt'] as String?
    ..qualificationStartDatetime = json['qualificationStartDatetime'] as String?
    ..qualificationEndDatetime = json['qualificationEndDatetime'] as String?
    ..qualificationWeekdaysOnly = json['qualificationWeekdaysOnly'] as bool?
    ..adminId = json['adminId'] as int?
    ..eventCompetition = json['eventCompetition'] as String?
    ..eventType = json['eventType'] as String?
    ..acara = json['acara'] as String?
    ..eventUrl = json['eventUrl'] as String?
    ..flatCategories = (json['flatCategories'] as List<dynamic>?)
        ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..detailCity = json['detailCity'] == null
        ? null
        : RegionModel.fromJson(json['detailCity'] as Map<String, dynamic>)
    ..eventSlug = json['eventSlug'] as String?
    ..picCallCenter = json['picCallCenter'] as String?
    ..eventStartElimination = json['eventStartElimination'] as String?
    ..eventEndElimination = json['eventEndElimination'] as String?;
}

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
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
      'isFlatRegistrationFee': instance.isFlatRegistrationFee,
      'publishedDatetime': instance.publishedDatetime,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'qualificationStartDatetime': instance.qualificationStartDatetime,
      'qualificationEndDatetime': instance.qualificationEndDatetime,
      'qualificationWeekdaysOnly': instance.qualificationWeekdaysOnly,
      'adminId': instance.adminId,
      'eventCompetition': instance.eventCompetition,
      'eventType': instance.eventType,
      'acara': instance.acara,
      'eventUrl': instance.eventUrl,
      'flatCategories': instance.flatCategories,
      'detailCity': instance.detailCity,
      'eventSlug': instance.eventSlug,
      'picCallCenter': instance.picCallCenter,
      'eventStartElimination': instance.eventStartElimination,
      'eventEndElimination': instance.eventEndElimination,
    };
