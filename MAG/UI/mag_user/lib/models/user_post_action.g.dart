// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_post_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPostAction _$UserPostActionFromJson(Map<String, dynamic> json) =>
    UserPostAction(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      postId: json['postId'] as int?,
      action: json['action'] as String?,
    );

Map<String, dynamic> _$UserPostActionToJson(UserPostAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'postId': instance.postId,
      'action': instance.action,
    };
