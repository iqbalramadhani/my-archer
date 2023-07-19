

import 'package:json_annotation/json_annotation.dart';

part 'category_general_model.g.dart';

@JsonSerializable()
class CategoryGeneralModel {
  String? id;
  String? label;

  CategoryGeneralModel();

  factory CategoryGeneralModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryGeneralModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryGeneralModelToJson(this);
}
