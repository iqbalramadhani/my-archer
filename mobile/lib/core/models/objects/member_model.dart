
import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  int? id;
  int? archeryEventParticipantId;
  String? name;
  String? teamCategoryId;
  String? email;
  dynamic phoneNumber;
  String? club;
  dynamic age;
  String? gender;
  String? qualificationDate;
  String? createdAt;
  String? updatedAt;
  String? birthdate;

  MemberModel();

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
