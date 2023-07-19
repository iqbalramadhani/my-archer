

import 'package:json_annotation/json_annotation.dart';

part 'role_model.g.dart';

@JsonSerializable()
class RoleModel {
  int? id;
  String? name;
  String? displayName;
  String? description;
  dynamic createdAt;
  dynamic updatedAt;

  RoleModel();

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoleModelToJson(this);
}
