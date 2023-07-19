

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/profile_model.dart';

part 'schedule_holiday_model.g.dart';

@JsonSerializable()
class ScheduleHolidayModel {
  int? id;
  int? placeId;
  String? startAt;
  String? endAt;
  String? createdAt;
  String? updatedAt;


  ScheduleHolidayModel(
      {this.id,
      this.placeId,
      this.startAt,
      this.endAt,
      this.createdAt,
      this.updatedAt});

  factory ScheduleHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleHolidayModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleHolidayModelToJson(this);
}
