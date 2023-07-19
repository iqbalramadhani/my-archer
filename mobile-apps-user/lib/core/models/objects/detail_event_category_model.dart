

import 'package:json_annotation/json_annotation.dart';

import 'team_category_detail.dart';

part 'detail_event_category_model.g.dart';

@JsonSerializable()
class DetailEventCategoryModel {
  TeamCategoryDetail? ageCategoryId;
  TeamCategoryDetail? competitionCategoryId;
  TeamCategoryDetail? distanceId;
  TeamCategoryDetail? teamCategoryId;
  int? categoryDetailsId;
  int? quota;
  String? fee;
  int? totalParticipant;

  DetailEventCategoryModel();

  factory DetailEventCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$DetailEventCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailEventCategoryModelToJson(this);
}
