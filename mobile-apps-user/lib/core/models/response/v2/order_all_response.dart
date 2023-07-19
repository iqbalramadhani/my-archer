import 'package:json_annotation/json_annotation.dart';
import 'package:myarchery_archer/core/models/objects/event_model.dart';

import '../base_response.dart';

part 'order_all_response.g.dart';

@JsonSerializable()
class OrderAllResponse extends BaseResponse {
  List<DataOrderAllModel>? data;

  OrderAllResponse();

  factory OrderAllResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderAllResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderAllResponseToJson(this);
}

@JsonSerializable()
class DataOrderAllModel {
  DetailOrderModel? detailOrder;
  dynamic transactionLogInfo;
  EventModel? detailEvent;
  _CategoryModel? category;


  DataOrderAllModel(
      {this.detailOrder,
      this.transactionLogInfo,
      this.detailEvent,
      this.category});

  factory DataOrderAllModel.fromJson(Map<String, dynamic> json) =>
      _$DataOrderAllModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataOrderAllModelToJson(this);
}

@JsonSerializable()
class DetailOrderModel {
  int? id;
  String? type;

  DetailOrderModel();

  factory DetailOrderModel.fromJson(Map<String, dynamic> json) =>
      _$DetailOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailOrderModelToJson(this);
}

@JsonSerializable()
class _CategoryModel {
  String? teamCategoryId;
  String? ageCategoryId;
  String? competitionCategoryId;
  int? distanceId;
  String? label;

  _CategoryModel();

  factory _CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$_CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$_CategoryModelToJson(this);
}
