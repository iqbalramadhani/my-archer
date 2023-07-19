

import 'package:json_annotation/json_annotation.dart';

import '../objects/member_club_model.dart';
import 'base_response.dart';

part 'club_member_response.g.dart';

@JsonSerializable()
class ClubMemberResponse extends BaseResponse {
  List<MemberClubModel>? data;

  ClubMemberResponse();

  factory ClubMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$ClubMemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClubMemberResponseToJson(this);
}
