

import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FaqModel {
  int? id;
  int? eventId;
  int? sort;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;
  int? isHide;

  FaqModel();

  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      _$FaqModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}
