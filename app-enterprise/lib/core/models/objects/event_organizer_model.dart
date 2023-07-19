

import 'package:json_annotation/json_annotation.dart';

part 'event_organizer_model.g.dart';

@JsonSerializable()
class EventOrganizerModel {
  int? id;
  String? eoName;
  dynamic createdAt;
  dynamic updatedAt;

  EventOrganizerModel();

  factory EventOrganizerModel.fromJson(Map<String, dynamic> json) =>
      _$EventOrganizerModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventOrganizerModelToJson(this);
}
