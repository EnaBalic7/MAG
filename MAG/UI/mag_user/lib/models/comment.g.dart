// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['id'] as int?,
      json['postId'] as int?,
      json['userId'] as int?,
      json['content'] as String?,
      json['likesCount'] as int?,
      json['dislikesCount'] as int?,
      json['dateCommented'] == null
          ? null
          : DateTime.parse(json['dateCommented'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'content': instance.content,
      'likesCount': instance.likesCount,
      'dislikesCount': instance.dislikesCount,
      'dateCommented': instance.dateCommented?.toIso8601String(),
    };
