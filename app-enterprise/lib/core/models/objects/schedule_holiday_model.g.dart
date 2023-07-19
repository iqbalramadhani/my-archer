// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_holiday_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleHolidayModel _$ScheduleHolidayModelFromJson(
        Map<String, dynamic> json) =>
    ScheduleHolidayModel(
      id: json['id'] as int?,
      placeId: json['placeId'] as int?,
      startAt: json['startAt'] as String?,
      endAt: json['endAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ScheduleHolidayModelToJson(
        ScheduleHolidayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
