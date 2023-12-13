import 'package:json_annotation/json_annotation.dart';
part 'genre_anime.g.dart';

@JsonSerializable()
class GenreAnime {
  int? id;
  int? genreId;
  int? animeId;

  GenreAnime(
    this.id,
    this.genreId,
    this.animeId,
  );

  factory GenreAnime.fromJson(Map<String, dynamic> json) =>
      _$GenreAnimeFromJson(json);

  Map<String, dynamic> toJson() => _$GenreAnimeToJson(this);
}
