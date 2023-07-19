

import 'package:json_annotation/json_annotation.dart';
import 'package:myarcher_enterprise/core/models/objects/data_login_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? message;
  dynamic errors;
  DataLoginModel? data;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
