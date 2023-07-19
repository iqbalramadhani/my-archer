

import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';
import 'region_model.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  int? id;
  String? poster;
  String? handbook;
  String? eventName;
  String? registrationStartDatetime;
  String? registrationEndDatetime;
  String? eventStartDatetime;
  String? eventEndDatetime;
  String? location;
  String? locationType;
  String? description;
  bool? isFlatRegistrationFee;
  String? publishedDatetime;
  String? createdAt;
  String? updatedAt;
  String? qualificationStartDatetime;
  String? qualificationEndDatetime;
  bool? qualificationWeekdaysOnly;
  int? adminId;
  String? eventCompetition;
  String? eventType;
  String? acara;
  String? eventUrl;
  List<CategoryModel>? flatCategories;
  RegionModel? detailCity;

  String? eventSlug;
  String? picCallCenter;
  String? eventStartElimination;
  String? eventEndElimination;

  EventModel();

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
