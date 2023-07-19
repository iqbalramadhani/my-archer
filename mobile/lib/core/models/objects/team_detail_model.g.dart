// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamDetailModel _$TeamDetailModelFromJson(Map<String, dynamic> json) =>
    TeamDetailModel()
      ..participantId = json['participantId'] as int?
      ..teamName = json['teamName'] as String?
      ..club = json['club'] == null
          ? null
          : ClubModel.fromJson(json['club'] as Map<String, dynamic>);

Map<String, dynamic> _$TeamDetailModelToJson(TeamDetailModel instance) =>
    <String, dynamic>{
      'participantId': instance.participantId,
      'teamName': instance.teamName,
      'club': instance.club,
    };
