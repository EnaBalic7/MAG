// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferred_genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferredGenre _$PreferredGenreFromJson(Map<String, dynamic> json) =>
    PreferredGenre(
      id: json['id'] as int?,
      genreId: json['genreId'] as int?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$PreferredGenreToJson(PreferredGenre instance) =>
    <String, dynamic>{
      'id': instance.id,
      'genreId': instance.genreId,
      'userId': instance.userId,
    };
