

import 'package:json_annotation/json_annotation.dart';

part 'event_more_info_model.g.dart';

@JsonSerializable()
class EventMoreInfoModel {
  int? id;
  int? eventId;
  String? title;
  String? description;

  EventMoreInfoModel();

  factory EventMoreInfoModel.fromJson(Map<String, dynamic> json) =>
      _$EventMoreInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventMoreInfoModelToJson(this);
}
