

import 'package:json_annotation/json_annotation.dart';

part 'category_model_v2.g.dart';

@JsonSerializable()
class CategoryModelV2 {
  int? id;
  int? eventId;
  String? ageCategoryId;
  String? competitionCategoryId;
  String? distanceId;
  String? teamCategoryId;
  int? isShow;
  String? categoryTeam;
  String? genderCategory;
  String? labelCategory;
  String? classCategory;
  int? quota;
  String? normalFee;
  String? earlyBirdFee;
  int? isEarlyBird;
  int? totalParticipant;

  CategoryModelV2();

  factory CategoryModelV2.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelV2FromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelV2ToJson(this);
}
