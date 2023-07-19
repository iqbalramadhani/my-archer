

import 'package:json_annotation/json_annotation.dart';
import 'package:my_archery/core/models/objects/profile_model.dart';

part 'data_login_model.g.dart';

@JsonSerializable()
class DataLoginModel {
  ProfileModel? profile;
  String? accessToken;
  String? tokenType;
  dynamic expiresIn;

  DataLoginModel();

  factory DataLoginModel.fromJson(Map<String, dynamic> json) =>
      _$DataLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataLoginModelToJson(this);
}
