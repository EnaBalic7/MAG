// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['id'] as int?,
      json['clubId'] as int?,
      json['userId'] as int?,
      json['content'] as String?,
      json['likesCount'] as int?,
      json['dislikesCount'] as int?,
      json['datePosted'] == null
          ? null
          : DateTime.parse(json['datePosted'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'clubId': instance.clubId,
      'userId': instance.userId,
      'content': instance.content,
      'likesCount': instance.likesCount,
      'dislikesCount': instance.dislikesCount,
      'datePosted': instance.datePosted?.toIso8601String(),
    };
