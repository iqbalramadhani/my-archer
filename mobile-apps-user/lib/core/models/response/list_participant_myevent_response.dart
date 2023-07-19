

import 'package:json_annotation/json_annotation.dart';
import '../objects/category_detail_model.dart';
import '../objects/club_model.dart';
import '../objects/participant_model.dart';
import '../objects/profile_model.dart';
import 'base_response.dart';

part 'list_participant_myevent_response.g.dart';

@JsonSerializable()
class ListParticipantMyEventResponse extends BaseResponse {

  DataModel? data;

  ListParticipantMyEventResponse();

  factory ListParticipantMyEventResponse.fromJson(Map<String, dynamic> json) =>
      _$ListParticipantMyEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListParticipantMyEventResponseToJson(this);
}


@JsonSerializable()
class DataModel{
  ParticipantModel? participant;
  CategoryDetailModel? eventCategoryDetail;
  // List<ProfileModel>? member;
  // DetailClubModel? club;

  ProfileModel? member;
  List<DetailClubModel>? club;

  DataModel();

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
