// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel()
    ..cityId = json['cityId']
    ..nameCity = json['nameCity']
    ..provinceId = json['provinceId']
    ..provinceName = json['provinceName'];
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'cityId': instance.cityId,
      'nameCity': instance.nameCity,
      'provinceId': instance.provinceId,
      'provinceName': instance.provinceName,
    };
