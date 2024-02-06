// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QA _$QAFromJson(Map<String, dynamic> json) => QA(
      json['id'] as int?,
      json['userId'] as int?,
      json['categoryId'] as int?,
      json['question'] as String?,
      json['answer'] as String?,
      json['displayed'] as bool?,
      json['category'] == null
          ? null
          : QAcategory.fromJson(json['category'] as Map<String, dynamic>),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QAToJson(QA instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'categoryId': instance.categoryId,
      'question': instance.question,
      'answer': instance.answer,
      'displayed': instance.displayed,
      'category': instance.category,
      'user': instance.user,
    };
