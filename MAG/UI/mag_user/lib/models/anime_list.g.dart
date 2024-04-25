// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeList _$AnimeListFromJson(Map<String, dynamic> json) => AnimeList(
      json['id'] as int?,
      json['listId'] as int?,
      json['animeId'] as int?,
      json['anime'] == null
          ? null
          : Anime.fromJson(json['anime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeListToJson(AnimeList instance) => <String, dynamic>{
      'id': instance.id,
      'listId': instance.listId,
      'animeId': instance.animeId,
      'anime': instance.anime,
    };
