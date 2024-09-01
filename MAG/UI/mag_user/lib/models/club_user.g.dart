// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubUser _$ClubUserFromJson(Map<String, dynamic> json) => ClubUser(
      (json['id'] as num?)?.toInt(),
      (json['clubId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClubUserToJson(ClubUser instance) => <String, dynamic>{
      'id': instance.id,
      'clubId': instance.clubId,
      'userId': instance.userId,
    };
