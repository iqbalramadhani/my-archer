// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_public_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPublicInformationModel _$EventPublicInformationModelFromJson(
    Map<String, dynamic> json) {
  return EventPublicInformationModel()
    ..eventName = json['eventName'] as String?
    ..eventBanner = json['eventBanner'] as String?
    ..handbook = json['handbook'] as String?
    ..eventDescription = json['eventDescription'] as String?
    ..eventLocation = json['eventLocation'] as String?
    ..eventCity = json['eventCity'] == null
        ? null
        : CityModel.fromJson(json['eventCity'] as Map<String, dynamic>)
    ..eventLocationType = json['eventLocationType'] as String?
    ..eventStartRegister = json['eventStartRegister'] as String?
    ..eventEndRegister = json['eventEndRegister'] as String?
    ..eventStart = json['eventStart'] as String?
    ..eventEnd = json['eventEnd'] as String?
    ..eventStatus = json['eventStatus']
    ..eventSlug = json['eventSlug'] as String?
    ..eventUrl = json['eventUrl'] as String?;
}

Map<String, dynamic> _$EventPublicInformationModelToJson(
        EventPublicInformationModel instance) =>
    <String, dynamic>{
      'eventName': instance.eventName,
      'eventBanner': instance.eventBanner,
      'handbook': instance.handbook,
      'eventDescription': instance.eventDescription,
      'eventLocation': instance.eventLocation,
      'eventCity': instance.eventCity,
      'eventLocationType': instance.eventLocationType,
      'eventStartRegister': instance.eventStartRegister,
      'eventEndRegister': instance.eventEndRegister,
      'eventStart': instance.eventStart,
      'eventEnd': instance.eventEnd,
      'eventStatus': instance.eventStatus,
      'eventSlug': instance.eventSlug,
      'eventUrl': instance.eventUrl,
    };
