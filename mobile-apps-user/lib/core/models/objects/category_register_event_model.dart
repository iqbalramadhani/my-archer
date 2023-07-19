

import 'package:json_annotation/json_annotation.dart';

import 'team_category_detail.dart';

part 'category_register_event_model.g.dart';

@JsonSerializable()
class CategoryRegisterEventModel {
  int? id;
  int? eventId;
  String? ageCategoryId;
  String? competitionCategoryId;
  String? distanceId;
  String? teamCategoryId;
  int? quota;
  String? createdAt;
  String? updatedAt;
  String? fee;
  String? earlyBird;
  bool? isOpen;
  int? isEarlyBird;
  bool? isHide;
  int? totalParticipant;
  String? categoryLabel;
  TeamCategoryDetail? teamCategoryDetail;


  CategoryRegisterEventModel(
      {this.id,
      this.eventId,
      this.ageCategoryId,
      this.competitionCategoryId,
      this.distanceId,
      this.teamCategoryId,
      this.quota,
      this.createdAt,
      this.updatedAt,
      this.fee,
        this.earlyBird,
      this.isOpen,
        this.isEarlyBird,
      this.totalParticipant,
      this.categoryLabel,
      this.teamCategoryDetail});

  factory CategoryRegisterEventModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryRegisterEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryRegisterEventModelToJson(this);
}
