

import 'package:json_annotation/json_annotation.dart';
import '../objects/v2/faq_model.dart';
import 'base_response.dart';

part 'faq_response.g.dart';

@JsonSerializable()
class FaqResponse extends BaseResponse {
  List<FaqModel>? data;

  FaqResponse();

  factory FaqResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FaqResponseToJson(this);
}
