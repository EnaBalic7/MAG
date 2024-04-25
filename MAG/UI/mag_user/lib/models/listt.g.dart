// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Listt _$ListtFromJson(Map<String, dynamic> json) => Listt(
      json['id'] as int?,
      json['userId'] as int?,
      json['name'] as String?,
      json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
    );

Map<String, dynamic> _$ListtToJson(Listt instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'dateCreated': instance.dateCreated?.toIso8601String(),
    };
