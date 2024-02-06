// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      json['id'] as int?,
      json['userId'] as int?,
      json['animeId'] as int?,
      json['ratingValue'] as int?,
      json['reviewText'] as String?,
      json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'animeId': instance.animeId,
      'ratingValue': instance.ratingValue,
      'reviewText': instance.reviewText,
      'dateAdded': instance.dateAdded?.toIso8601String(),
    };
