// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Anime _$AnimeFromJson(Map<String, dynamic> json) => Anime(
      json['id'] as int?,
      json['titleEn'] as String?,
      json['titleJp'] as String?,
      json['synopsis'] as String?,
      json['episodesNumber'] as int?,
      json['imageUrl'] as String?,
      json['trailerUrl'] as String?,
      (json['score'] as num?)?.toDouble(),
      json['beginAir'] == null
          ? null
          : DateTime.parse(json['beginAir'] as String),
      json['finishAir'] == null
          ? null
          : DateTime.parse(json['finishAir'] as String),
      json['season'] as String?,
      json['studio'] as String?,
      (json['genreAnimes'] as List<dynamic>?)
          ?.map((e) => GenreAnime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimeToJson(Anime instance) => <String, dynamic>{
      'id': instance.id,
      'titleEn': instance.titleEn,
      'titleJp': instance.titleJp,
      'synopsis': instance.synopsis,
      'episodesNumber': instance.episodesNumber,
      'imageUrl': instance.imageUrl,
      'trailerUrl': instance.trailerUrl,
      'score': instance.score,
      'beginAir': instance.beginAir?.toIso8601String(),
      'finishAir': instance.finishAir?.toIso8601String(),
      'season': instance.season,
      'studio': instance.studio,
      'genreAnimes': instance.genreAnimes,
    };
