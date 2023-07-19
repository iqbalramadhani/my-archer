

import 'package:json_annotation/json_annotation.dart';
import '../../objects/city_model.dart';
import '../../objects/event_more_info_model.dart';
import '../../objects/profile_model.dart';
import '../base_response.dart';

part 'detail_event_response_v2.g.dart';

@JsonSerializable()
class DetailEventResponseV2 extends BaseResponse {

  DataDetailEventModel? data;

  DetailEventResponseV2();

  factory DetailEventResponseV2.fromJson(Map<String, dynamic> json) =>
      _$DetailEventResponseV2FromJson(json);

  Map<String, dynamic> toJson() => _$DetailEventResponseV2ToJson(this);
}


@JsonSerializable()
class DataDetailEventModel extends BaseResponse {
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
  int? adminId;
  String? eventSlug;
  String? eventCompetition;
  int? cityId;
  int? status;
  String? eventType;
  int? needVerify;
  ProfileModel? detailAdmin;
  CityModel? detailCity;
  String? eventStatus;
  List<EventMoreInfoModel>? moreInformation;
  dynamic eventPrice;


  DataDetailEventModel(
      {this.id,
      this.poster,
      this.handbook,
      this.eventName,
      this.registrationStartDatetime,
      this.registrationEndDatetime,
      this.eventStartDatetime,
      this.eventEndDatetime,
      this.location,
      this.locationType,
      this.description,
      this.adminId,
      this.eventSlug,
      this.eventCompetition,
      this.cityId,
      this.status,
      this.eventType,
      this.needVerify,
      this.detailAdmin,
      this.detailCity,
      this.eventStatus,
      this.moreInformation,
      this.eventPrice});

  factory DataDetailEventModel.fromJson(Map<String, dynamic> json) =>
      _$DataDetailEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailEventModelToJson(this);
}
