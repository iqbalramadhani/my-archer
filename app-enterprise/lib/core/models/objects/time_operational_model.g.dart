// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_operational_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeOperationalModel _$TimeOperationalModelFromJson(
        Map<String, dynamic> json) =>
    TimeOperationalModel(
      id: json['id'] as int,
      placeId: json['placeId'] as int,
      day: json['day'] as String?,
      openTime: json['openTime'] as String?,
      closedTime: json['closedTime'] as String?,
      startBreakTime: json['startBreakTime'] as String?,
      endBreakTime: json['endBreakTime'] as String?,
      isOpen: json['isOpen'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TimeOperationalModelToJson(
        TimeOperationalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'day': instance.day,
      'openTime': instance.openTime,
      'closedTime': instance.closedTime,
      'startBreakTime': instance.startBreakTime,
      'endBreakTime': instance.endBreakTime,
      'isOpen': instance.isOpen,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
