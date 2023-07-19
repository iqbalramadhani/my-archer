

import 'package:json_annotation/json_annotation.dart';

import '../objects/participant_model.dart';
import 'base_response.dart';

part 'check_email_event_response.g.dart';

@JsonSerializable()
class CheckEmailEventResponse extends BaseResponse {
  List<ParticipantModel>? data;

  CheckEmailEventResponse();

  factory CheckEmailEventResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckEmailEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckEmailEventResponseToJson(this);
}
