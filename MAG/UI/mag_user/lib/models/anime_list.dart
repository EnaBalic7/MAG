import 'package:json_annotation/json_annotation.dart';

import 'anime.dart';

part 'anime_list.g.dart';

@JsonSerializable()
class AnimeList {
  int? id;
  int? listId;
  int? animeId;
  Anime? anime;

  AnimeList(this.id, this.listId, this.animeId, this.anime);

  factory AnimeList.fromJson(Map<String, dynamic> json) =>
      _$AnimeListFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeListToJson(this);
}
