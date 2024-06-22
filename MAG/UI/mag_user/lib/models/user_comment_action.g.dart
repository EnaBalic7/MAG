// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comment_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCommentAction _$UserCommentActionFromJson(Map<String, dynamic> json) =>
    UserCommentAction(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      commentId: json['commentId'] as int?,
      action: json['action'] as String?,
    );

Map<String, dynamic> _$UserCommentActionToJson(UserCommentAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'commentId': instance.commentId,
      'action': instance.action,
    };
