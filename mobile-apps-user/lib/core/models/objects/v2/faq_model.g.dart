// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqModel _$FaqModelFromJson(Map<String, dynamic> json) {
  return FaqModel()
    ..id = json['id'] as int?
    ..eventId = json['eventId'] as int?
    ..sort = json['sort'] as int?
    ..question = json['question'] as String?
    ..answer = json['answer'] as String?
    ..createdAt = json['createdAt'] as String?
    ..updatedAt = json['updatedAt'] as String?
    ..isHide = json['isHide'] as int?;
}

Map<String, dynamic> _$FaqModelToJson(FaqModel instance) => <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'sort': instance.sort,
      'question': instance.question,
      'answer': instance.answer,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isHide': instance.isHide,
    };
