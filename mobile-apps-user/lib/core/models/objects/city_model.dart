

import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  dynamic cityId;
  dynamic nameCity;
  dynamic provinceId;
  dynamic provinceName;

  CityModel();

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
