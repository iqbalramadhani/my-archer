// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_holiday_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleHolidayResponse _$ScheduleHolidayResponseFromJson(
        Map<String, dynamic> json) =>
    ScheduleHolidayResponse()
      ..message = json['message'] as String?
      ..errors = json['errors']
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => ScheduleHolidayModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ScheduleHolidayResponseToJson(
        ScheduleHolidayResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
