

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/schedule_holiday_model.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/core/models/responses/base_response.dart';

part 'schedule_holiday_response.g.dart';

@JsonSerializable()
class ScheduleHolidayResponse extends BaseResponse {
  List<ScheduleHolidayModel>? data;

  ScheduleHolidayResponse();

  factory ScheduleHolidayResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleHolidayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleHolidayResponseToJson(this);
}
