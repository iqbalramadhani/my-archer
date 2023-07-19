

import 'package:json_annotation/json_annotation.dart';

import 'city_model.dart';

part 'event_public_information_model.g.dart';

@JsonSerializable()
class EventPublicInformationModel {
  String? eventName;
  String? eventBanner;
  String? handbook;
  String? eventDescription;
  String? eventLocation;
  CityModel? eventCity;
  String? eventLocationType;
  String? eventStartRegister;
  String? eventEndRegister;
  String? eventStart;
  String? eventEnd;
  dynamic eventStatus;
  String? eventSlug;
  String? eventUrl;

  EventPublicInformationModel();

  factory EventPublicInformationModel.fromJson(Map<String, dynamic> json) =>
      _$EventPublicInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventPublicInformationModelToJson(this);
}
