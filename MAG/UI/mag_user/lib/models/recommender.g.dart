// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommender _$RecommenderFromJson(Map<String, dynamic> json) => Recommender(
      (json['id'] as num?)?.toInt(),
      (json['animeId'] as num?)?.toInt(),
      (json['coAnimeId1'] as num?)?.toInt(),
      (json['coAnimeId2'] as num?)?.toInt(),
      (json['coAnimeId3'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecommenderToJson(Recommender instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animeId': instance.animeId,
      'coAnimeId1': instance.coAnimeId1,
      'coAnimeId2': instance.coAnimeId2,
      'coAnimeId3': instance.coAnimeId3,
    };
