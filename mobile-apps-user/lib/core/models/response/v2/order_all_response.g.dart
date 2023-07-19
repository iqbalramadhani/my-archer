// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_all_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAllResponse _$OrderAllResponseFromJson(Map<String, dynamic> json) {
  return OrderAllResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => DataOrderAllModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$OrderAllResponseToJson(OrderAllResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataOrderAllModel _$DataOrderAllModelFromJson(Map<String, dynamic> json) {
  return DataOrderAllModel(
    detailOrder: json['detailOrder'] == null
        ? null
        : DetailOrderModel.fromJson(
            json['detailOrder'] as Map<String, dynamic>),
    transactionLogInfo: json['transactionLogInfo'],
    detailEvent: json['detailEvent'] == null
        ? null
        : EventModel.fromJson(json['detailEvent'] as Map<String, dynamic>),
    category: json['category'] == null
        ? null
        : _CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataOrderAllModelToJson(DataOrderAllModel instance) =>
    <String, dynamic>{
      'detailOrder': instance.detailOrder,
      'transactionLogInfo': instance.transactionLogInfo,
      'detailEvent': instance.detailEvent,
      'category': instance.category,
    };

DetailOrderModel _$DetailOrderModelFromJson(Map<String, dynamic> json) {
  return DetailOrderModel()
    ..id = json['id'] as int?
    ..type = json['type'] as String?;
}

Map<String, dynamic> _$DetailOrderModelToJson(DetailOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_CategoryModel _$_CategoryModelFromJson(Map<String, dynamic> json) {
  return _CategoryModel()
    ..teamCategoryId = json['teamCategoryId'] as String?
    ..ageCategoryId = json['ageCategoryId'] as String?
    ..competitionCategoryId = json['competitionCategoryId'] as String?
    ..distanceId = json['distanceId'] as int?
    ..label = json['label'] as String?;
}

Map<String, dynamic> _$_CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'teamCategoryId': instance.teamCategoryId,
      'ageCategoryId': instance.ageCategoryId,
      'competitionCategoryId': instance.competitionCategoryId,
      'distanceId': instance.distanceId,
      'label': instance.label,
    };
