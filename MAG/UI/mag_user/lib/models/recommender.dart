import 'package:json_annotation/json_annotation.dart';
part 'recommender.g.dart';

@JsonSerializable()
class Recommender {
  int? id;
  int? animeId;
  int? coAnimeId1;
  int? coAnimeId2;
  int? coAnimeId3;

  Recommender(
      this.id, this.animeId, this.coAnimeId1, this.coAnimeId2, this.coAnimeId3);

  factory Recommender.fromJson(Map<String, dynamic> json) =>
      _$RecommenderFromJson(json);

  Map<String, dynamic> toJson() => _$RecommenderToJson(this);
}
