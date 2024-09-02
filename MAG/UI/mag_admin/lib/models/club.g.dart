// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
      (json['id'] as num?)?.toInt(),
      (json['ownerId'] as num?)?.toInt(),
      json['name'] as String?,
      json['description'] as String?,
      (json['memberCount'] as num?)?.toInt(),
      json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      json['cover'] == null
          ? null
          : ClubCover.fromJson(json['cover'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'memberCount': instance.memberCount,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'cover': instance.cover,
    };
