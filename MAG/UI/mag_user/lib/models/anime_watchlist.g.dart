// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_watchlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeWatchlist _$AnimeWatchlistFromJson(Map<String, dynamic> json) =>
    AnimeWatchlist(
      (json['id'] as num?)?.toInt(),
      (json['animeId'] as num?)?.toInt(),
      (json['watchlistId'] as num?)?.toInt(),
      json['watchStatus'] as String?,
      (json['progress'] as num?)?.toInt(),
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
