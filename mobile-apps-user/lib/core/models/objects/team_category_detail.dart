

import 'package:json_annotation/json_annotation.dart';

part 'team_category_detail.g.dart';

@JsonSerializable()
class TeamCategoryDetail {
  dynamic id;
  String? label;
  String? type;
  int? maxAge;


  TeamCategoryDetail({this.id, this.label});

  factory TeamCategoryDetail.fromJson(Map<String, dynamic> json) =>
      _$TeamCategoryDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TeamCategoryDetailToJson(this);
}
