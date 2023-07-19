

import 'package:json_annotation/json_annotation.dart';

import '../../objects/v2/category_model_v2.dart';
import '../base_response.dart';

part 'category_event_response_v2.g.dart';

@JsonSerializable()
class CategoryEventResponseV2 extends BaseResponse {

  List<CategoryModelV2>? data;

  CategoryEventResponseV2();

  factory CategoryEventResponseV2.fromJson(Map<String, dynamic> json) =>
      _$CategoryEventResponseV2FromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEventResponseV2ToJson(this);
}