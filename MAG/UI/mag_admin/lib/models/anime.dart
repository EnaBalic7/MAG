import 'package:json_annotation/json_annotation.dart';
part 'anime.g.dart';

@JsonSerializable()
class Anime {
  int? id;
  String? titleEn;
  String? titleJp;
  String? synopsis;
  int? episodesNumber;
  String? imageUrl;
  String? trailerUrl;
  double? score;
  DateTime? beginAir;
  DateTime? finishAir;
  String? season;
  String? studio;

  Anime(
      this.id,
      this.titleEn,
      this.titleJp,
      this.synopsis,
      this.episodesNumber,
      this.imageUrl,
      this.trailerUrl,
      this.score,
      this.beginAir,
      this.finishAir,
      this.season,
      this.studio);

  factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeToJson(this);
}
