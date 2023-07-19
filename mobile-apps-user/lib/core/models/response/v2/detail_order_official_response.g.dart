// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_order_official_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailOrderOfficialResponse _$DetailOrderOfficialResponseFromJson(
    Map<String, dynamic> json) {
  return DetailOrderOfficialResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = json['data'] == null
        ? null
        : _DataDetailOrderModel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DetailOrderOfficialResponseToJson(
        DetailOrderOfficialResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

_DataDetailOrderModel _$_DataDetailOrderModelFromJson(
    Map<String, dynamic> json) {
  return _DataDetailOrderModel()
    ..detailEventOfficial = json['detailEventOfficial'] == null
        ? null
        : DetailEventOfficialModel.fromJson(
            json['detailEventOfficial'] as Map<String, dynamic>)
    ..transactionInfo = json['transactionInfo'] == null
        ? null
        : TransactionInfoModel.fromJson(
            json['transactionInfo'] as Map<String, dynamic>)
    ..eventOfficialDetail = json['eventOfficialDetail'] == null
        ? null
        : _EventOfficialDetail.fromJson(
            json['eventOfficialDetail'] as Map<String, dynamic>)
    ..detailUser = json['detailUser'] == null
        ? null
        : MemberClubModel.fromJson(json['detailUser'] as Map<String, dynamic>)
    ..clubDetail = json['clubDetail'] == null
        ? null
        : MemberClubModel.fromJson(json['clubDetail'] as Map<String, dynamic>);
}

Map<String, dynamic> _$_DataDetailOrderModelToJson(
        _DataDetailOrderModel instance) =>
    <String, dynamic>{
      'detailEventOfficial': instance.detailEventOfficial,
      'transactionInfo': instance.transactionInfo,
      'eventOfficialDetail': instance.eventOfficialDetail,
      'detailUser': instance.detailUser,
      'clubDetail': instance.clubDetail,
    };

_EventOfficialDetail _$_EventOfficialDetailFromJson(Map<String, dynamic> json) {
  return _EventOfficialDetail()
    ..eventOfficialDetailId = json['eventOfficialDetailId'] as int?
    ..quota = json['quota'] as int?
    ..fee = json['fee'] as String?
    ..detailEvent = json['detailEvent'] == null
        ? null
        : DataDetailEventModel.fromJson(
            json['detailEvent'] as Map<String, dynamic>);
}

Map<String, dynamic> _$_EventOfficialDetailToJson(
        _EventOfficialDetail instance) =>
    <String, dynamic>{
      'eventOfficialDetailId': instance.eventOfficialDetailId,
      'quota': instance.quota,
      'fee': instance.fee,
      'detailEvent': instance.detailEvent,
    };
