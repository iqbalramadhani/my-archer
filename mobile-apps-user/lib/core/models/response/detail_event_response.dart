

import 'package:json_annotation/json_annotation.dart';

import '../objects/detail_event_category_model.dart';
import '../objects/event_more_info_model.dart';
import '../objects/event_public_information_model.dart';
import '../objects/profile_model.dart';
import 'base_response.dart';

part 'detail_event_response.g.dart';

@JsonSerializable()
class DetailEventResponse extends BaseResponse {

  DataDetailEventModel? data;

  DetailEventResponse();

  factory DetailEventResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailEventResponseToJson(this);
}


@JsonSerializable()
class DataDetailEventModel extends BaseResponse {
  int? id;
  String? eventType;
  String? eventCompetition;
  EventPublicInformationModel? publicInformation;
  List<EventMoreInfoModel>? moreInformation;
  List<DetailEventCategoryModel>? eventCategories;
  ProfileModel? admins;

  DataDetailEventModel();

  factory DataDetailEventModel.fromJson(Map<String, dynamic> json) =>
      _$DataDetailEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailEventModelToJson(this);
}
