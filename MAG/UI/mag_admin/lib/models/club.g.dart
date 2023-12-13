// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
      json['id'] as int?,
      json['ownerId'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['memberCount'] as int?,
      json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
    );

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'memberCount': instance.memberCount,
      'dateCreated': instance.dateCreated?.toIso8601String(),
    };
