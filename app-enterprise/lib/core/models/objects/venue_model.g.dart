// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueModel _$VenueModelFromJson(Map<String, dynamic> json) => VenueModel()
  ..id = json['id'] as int?
  ..eoId = json['eoId'] as int?
  ..name = json['name'] as String?
  ..description = json['description'] as String?
  ..placeType = json['placeType'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..latitude = json['latitude']
  ..longitude = json['longitude']
  ..address = json['address'] as String?
  ..provinceId = json['provinceId'] as int?
  ..cityId = json['cityId'] as int?
  ..province = json['province'] == null
      ? null
      : RegionModel.fromJson(json['province'] as Map<String, dynamic>)
  ..city = json['city'] == null
      ? null
      : RegionModel.fromJson(json['city'] as Map<String, dynamic>)
  ..status = json['status'] as int?
  ..createdAt = json['createdAt'] as String?
  ..updatedAt = json['updatedAt'] as String?
  ..galleries = (json['galleries'] as List<dynamic>?)
      ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..otherFacilities = (json['otherFacilities'] as List<dynamic>?)
      ?.map((e) => FacilityModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..facilities = (json['facilities'] as List<dynamic>?)
      ?.map((e) => FacilityModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$VenueModelToJson(VenueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eoId': instance.eoId,
      'name': instance.name,
      'description': instance.description,
      'placeType': instance.placeType,
      'phoneNumber': instance.phoneNumber,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'provinceId': instance.provinceId,
      'cityId': instance.cityId,
      'province': instance.province,
      'city': instance.city,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'galleries': instance.galleries,
      'otherFacilities': instance.otherFacilities,
      'facilities': instance.facilities,
    };
