import 'package:json_annotation/json_annotation.dart';

part 'anime_list.g.dart';

@JsonSerializable()
class AnimeList {
  int? id;
  int? listId;
  int? animeId;

  AnimeList(this.id, this.listId, this.animeId);

  factory AnimeList.fromJson(Map<String, dynamic> json) =>
      _$AnimeListFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeListToJson(this);
}
