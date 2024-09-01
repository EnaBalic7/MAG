// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreAnime _$GenreAnimeFromJson(Map<String, dynamic> json) => GenreAnime(
      (json['id'] as num?)?.toInt(),
      (json['genreId'] as num?)?.toInt(),
      (json['animeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GenreAnimeToJson(GenreAnime instance) =>
    <String, dynamic>{
      'id': instance.id,
      'genreId': instance.genreId,
      'animeId': instance.animeId,
    };
