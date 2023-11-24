import 'package:mag_admin/providers/base_provider.dart';

import '../models/genre_anime.dart';

class GenreAnimeProvider extends BaseProvider<GenreAnime> {
  GenreAnimeProvider() : super("GenreAnime");

  @override
  GenreAnime fromJson(data) {
    return GenreAnime.fromJson(data);
  }

  Future<void> saveGenresForAnime(int animeId, List<String> genreIds) async {
    await deleteGenresForAnime(animeId);

    for (var genreId in genreIds) {
      await insert(GenreAnime(null, int.parse(genreId), animeId));
    }
  }

  Future<void> deleteGenresForAnime(int animeId) async {
    // Delete all existing genres for the anime, must implement this in backend
    //await delete(where: 'animeId = ?', whereArgs: [animeId]);
  }
}
