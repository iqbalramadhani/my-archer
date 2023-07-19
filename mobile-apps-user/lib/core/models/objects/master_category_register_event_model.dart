

import 'package:json_annotation/json_annotation.dart';

import 'category_register_event_model.dart';

part 'master_category_register_event_model.g.dart';

@JsonSerializable()
class MasterCategoryRegisterEventModel {
  String? name;
  List<CategoryRegisterEventModel>? datas;


  MasterCategoryRegisterEventModel({this.name, this.datas});

  factory MasterCategoryRegisterEventModel.fromJson(Map<String, dynamic> json) =>
      _$MasterCategoryRegisterEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$MasterCategoryRegisterEventModelToJson(this);
}
