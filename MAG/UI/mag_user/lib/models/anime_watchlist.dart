import 'package:json_annotation/json_annotation.dart';

import 'anime.dart';
part 'anime_watchlist.g.dart';

@JsonSerializable()
class AnimeWatchlist {
  int? id;
  int? animeId;
  int? watchlistId;
  String? watchStatus;
  int? progress;
  DateTime? dateStarted;
  DateTime? dateFinished;
  Anime? anime;

  AnimeWatchlist(
    this.id,
    this.animeId,
    this.watchlistId,
    this.watchStatus,
    this.progress,
    this.dateStarted,
    this.dateFinished,
    this.anime,
  );

  factory AnimeWatchlist.fromJson(Map<String, dynamic> json) =>
      _$AnimeWatchlistFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeWatchlistToJson(this);
}
