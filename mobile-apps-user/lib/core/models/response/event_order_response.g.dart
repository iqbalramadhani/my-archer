// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventOrderResponse _$EventOrderResponseFromJson(Map<String, dynamic> json) {
  return EventOrderResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$EventOrderResponseToJson(EventOrderResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel()
    ..archeryEvent = json['archeryEvent'] == null
        ? null
        : EventModel.fromJson(json['archeryEvent'] as Map<String, dynamic>)
    ..participant = json['participant'] == null
        ? null
        : ParticipantModel.fromJson(json['participant'] as Map<String, dynamic>)
    ..transactionInfo = json['transactionInfo'] == null
        ? null
        : TransactionInfoModel.fromJson(
            json['transactionInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'archeryEvent': instance.archeryEvent,
      'participant': instance.participant,
      'transactionInfo': instance.transactionInfo,
    };
