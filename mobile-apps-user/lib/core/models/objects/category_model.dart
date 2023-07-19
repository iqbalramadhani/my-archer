

import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  int? archeryEventId;
  String? ageCategoryId;
  int? forAge;
  String? ageCategoryLabel;
  String? competitionCategoryId;
  String? competitionCategoryLabel;
  String? teamCategoryId;
  String? teamCategoryLabel;
  String? distanceId;
  String? distanceLabel;
  String? archeryEventCategoryLabel;

  CategoryModel();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
