

import 'package:json_annotation/json_annotation.dart';

import 'detail_participant_model.dart';
import 'team_category_detail.dart';

part 'category_detail_model.g.dart';

@JsonSerializable()
class CategoryDetailModel {
  int? id;
  int? quota;
  String? fee;
  String? genderCategory;
  String? categoryLabel;
  String? categoryType;
  dynamic haveSeries;
  dynamic canUpdateSeries;
  dynamic canJoinSeries;
  TeamCategoryDetail? categoryTeam;
  TeamCategoryDetail? ageCategoryDetail;
  TeamCategoryDetail? competitionCategoryDetail;
  TeamCategoryDetail? distanceDetail;
  TeamCategoryDetail? teamCategoryDetail;
  DetailParticipantModel? detailParticipant;

  CategoryDetailModel();

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDetailModelToJson(this);
}
