// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubMemberResponse _$ClubMemberResponseFromJson(Map<String, dynamic> json) {
  return ClubMemberResponse()
    ..message = json['message'] as String?
    ..errors = json['errors']
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => MemberClubModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ClubMemberResponseToJson(ClubMemberResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
