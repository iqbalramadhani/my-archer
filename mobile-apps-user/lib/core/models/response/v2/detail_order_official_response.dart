import 'package:json_annotation/json_annotation.dart';
import 'package:myarchery_archer/core/models/objects/detail_event_official_model.dart';
import 'package:myarchery_archer/core/models/objects/event_model.dart';
import 'package:myarchery_archer/core/models/objects/member_club_model.dart';
import 'package:myarchery_archer/core/models/objects/transaction_info_model.dart';

import '../base_response.dart';
import '../detail_event_response.dart';

part 'detail_order_official_response.g.dart';

@JsonSerializable()
class DetailOrderOfficialResponse extends BaseResponse {
  _DataDetailOrderModel? data;

  DetailOrderOfficialResponse();

  factory DetailOrderOfficialResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailOrderOfficialResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailOrderOfficialResponseToJson(this);
}

@JsonSerializable()
class _DataDetailOrderModel {
  DetailEventOfficialModel? detailEventOfficial;
  TransactionInfoModel? transactionInfo;
  _EventOfficialDetail? eventOfficialDetail;
  MemberClubModel? detailUser;
  MemberClubModel? clubDetail;

  _DataDetailOrderModel();

  factory _DataDetailOrderModel.fromJson(Map<String, dynamic> json) =>
      _$_DataDetailOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$_DataDetailOrderModelToJson(this);
}

@JsonSerializable()
class _EventOfficialDetail {
  int? eventOfficialDetailId;
  int? quota;
  String? fee;
  DataDetailEventModel? detailEvent;

  _EventOfficialDetail();

  factory _EventOfficialDetail.fromJson(Map<String, dynamic> json) =>
      _$_EventOfficialDetailFromJson(json);

  Map<String, dynamic> toJson() => _$_EventOfficialDetailToJson(this);
}
