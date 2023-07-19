// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailEventResponse _$DetailEventResponseFromJson(Map<String, dynamic> json) {
  return DetailEventResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataDetailEventModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DetailEventResponseToJson(
        DetailEventResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataDetailEventModel _$DataDetailEventModelFromJson(Map<String, dynamic> json) {
  return DataDetailEventModel()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..id = json['id'] as int?
    ..eventType = json['eventType'] as String?
    ..eventCompetition = json['eventCompetition'] as String?
    ..publicInformation = json['publicInformation'] == null
        ? null
        : EventPublicInformationModel.fromJson(
            json['publicInformation'] as Map<String, dynamic>)
    ..moreInformation = (json['moreInformation'] as List<dynamic>?)
        ?.map((e) => EventMoreInfoModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..eventCategories = (json['eventCategories'] as List<dynamic>?)
        ?.map(
            (e) => DetailEventCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..admins = json['admins'] == null
        ? null
        : ProfileModel.fromJson(json['admins'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DataDetailEventModelToJson(
        DataDetailEventModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'eventType': instance.eventType,
      'eventCompetition': instance.eventCompetition,
      'publicInformation': instance.publicInformation,
      'moreInformation': instance.moreInformation,
      'eventCategories': instance.eventCategories,
      'admins': instance.admins,
    };
