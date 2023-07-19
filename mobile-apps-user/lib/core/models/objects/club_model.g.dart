// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) {
  return ClubModel()
    ..detail = json['detail'] == null
        ? null
        : DetailClubModel.fromJson(json['detail'] as Map<String, dynamic>)
    ..totalMember = json['totalMember'] as int?
    ..isJoin = json['isJoin'] as int?;
}

Map<String, dynamic> _$ClubModelToJson(ClubModel instance) => <String, dynamic>{
      'detail': instance.detail,
      'totalMember': instance.totalMember,
      'isJoin': instance.isJoin,
    };

DetailClubModel _$DetailClubModelFromJson(Map<String, dynamic> json) {
  return DetailClubModel()
    ..id = json['id'] as int?
    ..name = json['name'] as String?
    ..logo = json['logo'] as String?
    ..banner = json['banner'] as String?
    ..placeName = json['placeName'] as String?
    ..address = json['address'] as String?
    ..description = json['description'] as String?
    ..createdAt = json['createdAt'] as String?
    ..updatedAt = json['updatedAt'] as String?
    ..province = json['province']
    ..city = json['city']
    ..detailProvince = json['detailProvince'] == null
        ? null
        : RegionModel.fromJson(json['detailProvince'] as Map<String, dynamic>)
    ..detailCity = json['detailCity']
    ..totalMember = json['totalMember'] as int?
    ..isAdmin = json['isAdmin'] as int?
    ..isJoin = json['isJoin'] as int?;
}

Map<String, dynamic> _$DetailClubModelToJson(DetailClubModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'banner': instance.banner,
      'placeName': instance.placeName,
      'address': instance.address,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'province': instance.province,
      'city': instance.city,
      'detailProvince': instance.detailProvince,
      'detailCity': instance.detailCity,
      'totalMember': instance.totalMember,
      'isAdmin': instance.isAdmin,
      'isJoin': instance.isJoin,
    };
