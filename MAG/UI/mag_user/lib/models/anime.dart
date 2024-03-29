import 'package:json_annotation/json_annotation.dart';
import '../models/genre_anime.dart';
part 'anime.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs -> one time
// flutter pub run build_runner watch --delete-conflicting-outputs -> continuous

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
  List<GenreAnime>? genreAnimes;
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
    this.studio,
    this.genreAnimes,
  );

  factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeToJson(this);
}
