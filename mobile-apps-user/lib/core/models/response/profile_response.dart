import 'package:json_annotation/json_annotation.dart';
import '../objects/profile_model.dart';
import 'base_response.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse extends BaseResponse {
  ProfileModel? data;

  ProfileResponse();

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
