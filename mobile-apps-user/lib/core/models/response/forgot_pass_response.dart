

import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

part 'forgot_pass_response.g.dart';

@JsonSerializable()
class ForgotPassResponse extends BaseResponse {
  dynamic data;

  ForgotPassResponse();

  factory ForgotPassResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPassResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPassResponseToJson(this);
}
