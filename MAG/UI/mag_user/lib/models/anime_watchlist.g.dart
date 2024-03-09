// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_watchlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeWatchlist _$AnimeWatchlistFromJson(Map<String, dynamic> json) =>
    AnimeWatchlist(
      json['id'] as int?,
      json['animeId'] as int?,
      json['watchlistId'] as int?,
      json['watchStatus'] as String?,
      json['progress'] as int?,
      json['dateStarted'] == null
          ? null
          : DateTime.parse(json['dateStarted'] as String),
      json['dateFinished'] == null
          ? null
          : DateTime.parse(json['dateFinished'] as String),
      json['anime'] == null
          ? null
          : Anime.fromJson(json['anime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeWatchlistToJson(AnimeWatchlist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animeId': instance.animeId,
      'watchlistId': instance.watchlistId,
      'watchStatus': instance.watchStatus,
      'progress': instance.progress,
      'dateStarted': instance.dateStarted?.toIso8601String(),
      'dateFinished': instance.dateFinished?.toIso8601String(),
      'anime': instance.anime,
    };
