import 'package:mag_admin/providers/base_provider.dart';

import '../models/genre_anime.dart';
import 'dart:convert';

class GenreAnimeProvider extends BaseProvider<GenreAnime> {
  String _endpoint = "GenreAnime";
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

  Future<GenreAnime> deleteGenresForAnime(int animeId) async {
    var url = "${BaseProvider.baseUrl}$_endpoint/DeleteAllGenres/$animeId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.delete(uri, headers: headers);

    if (isValidResponse(response)) {
      if (response.body != "[]") {
        var data = jsonDecode(response.body);
        notifyListeners();
        return fromJson(data);
      }
      return GenreAnime(0, 0, 0);
    } else {
      throw Exception("Unknown error");
    }
  }
}
