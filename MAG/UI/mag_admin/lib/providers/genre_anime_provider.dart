import 'package:mag_admin/providers/base_provider.dart';

import '../models/genre_anime.dart';

class GenreAnimeProvider extends BaseProvider<GenreAnime> {
  GenreAnimeProvider() : super("GenreAnime");

  @override
  GenreAnime fromJson(data) {
    return GenreAnime.fromJson(data);
  }
}
