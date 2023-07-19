

import 'package:json_annotation/json_annotation.dart';

part 'time_operational_model.g.dart';

@JsonSerializable()
class TimeOperationalModel {
  int id;
  int placeId;
  String? day;
  String? openTime;
  String? closedTime;
  String? startBreakTime;
  String? endBreakTime;
  int? isOpen;
  String? createdAt;
  String? updatedAt;


  TimeOperationalModel(
      {required this.id,
      required this.placeId,
      this.day,
      this.openTime,
      this.closedTime,
      this.startBreakTime,
      this.endBreakTime,
      this.isOpen,
      this.createdAt,
      this.updatedAt});

  factory TimeOperationalModel.fromJson(Map<String, dynamic> json) =>
      _$TimeOperationalModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeOperationalModelToJson(this);
}
