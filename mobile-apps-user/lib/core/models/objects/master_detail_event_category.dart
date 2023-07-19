

import 'package:json_annotation/json_annotation.dart';
import 'detail_event_category_model.dart';

part 'master_detail_event_category.g.dart';

@JsonSerializable()
class MasterDetailEventCategoryModel {
  String? name;
  List<DetailEventCategoryModel>? datas;


  MasterDetailEventCategoryModel({this.name, this.datas});

  factory MasterDetailEventCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MasterDetailEventCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MasterDetailEventCategoryModelToJson(this);
}
