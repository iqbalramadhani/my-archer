

import 'package:json_annotation/json_annotation.dart';

import '../objects/objects.dart';

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
