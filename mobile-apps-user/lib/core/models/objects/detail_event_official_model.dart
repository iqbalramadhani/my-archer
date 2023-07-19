import 'package:json_annotation/json_annotation.dart';

part 'detail_event_official_model.g.dart';

@JsonSerializable()
class DetailEventOfficialModel {
  int? eventOfficialId;
  int? type;
  int? relationWithParticipant;
  String? relationWithParticipantLabel;
  int? status;
  String? statusLabel;
  String? teamCategoryId;
  String? categoryLabel;

  DetailEventOfficialModel();

  factory DetailEventOfficialModel.fromJson(Map<String, dynamic> json) =>
      _$DetailEventOfficialModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailEventOfficialModelToJson(this);
}
