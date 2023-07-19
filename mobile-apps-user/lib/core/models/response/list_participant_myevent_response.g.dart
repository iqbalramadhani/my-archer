// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_participant_myevent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListParticipantMyEventResponse _$ListParticipantMyEventResponseFromJson(
    Map<String, dynamic> json) {
  return ListParticipantMyEventResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : DataModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ListParticipantMyEventResponseToJson(
        ListParticipantMyEventResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel()
    ..participant = json['participant'] == null
        ? null
        : ParticipantModel.fromJson(json['participant'] as Map<String, dynamic>)
    ..eventCategoryDetail = json['eventCategoryDetail'] == null
        ? null
        : CategoryDetailModel.fromJson(
            json['eventCategoryDetail'] as Map<String, dynamic>)
    ..member = json['member'] == null
        ? null
        : ProfileModel.fromJson(json['member'] as Map<String, dynamic>)
    ..club = (json['club'] as List<dynamic>?)
        ?.map((e) => DetailClubModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'participant': instance.participant,
      'eventCategoryDetail': instance.eventCategoryDetail,
      'member': instance.member,
      'club': instance.club,
    };
