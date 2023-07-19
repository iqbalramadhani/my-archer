

import 'package:json_annotation/json_annotation.dart';
import '../objects/data_login_model.dart';
import 'base_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse {
  DataLoginModel? data;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
