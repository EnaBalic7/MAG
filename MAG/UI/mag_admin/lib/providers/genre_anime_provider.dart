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
    await deleteByAnimeId(animeId);

    for (var genreId in genreIds) {
      await insert(GenreAnime(null, int.parse(genreId), animeId));
    }
  }

  Future<bool> deleteByAnimeId(int animeId) async {
    var url = "${BaseProvider.baseUrl}$_endpoint/DeleteByAnimeId/$animeId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.delete(uri, headers: headers);

    if (isValidResponse(response)) {
      if (response.body == "true") {
        //var data = jsonDecode(response.body);
        notifyListeners();
        return true;
      }
      return true;
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<bool> deleteByGenreId(int genreId) async {
    var url = "${BaseProvider.baseUrl}$_endpoint/DeleteByGenreId/$genreId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.delete(uri, headers: headers);

    if (isValidResponse(response)) {
      return true;
    } else {
      throw Exception("Unknown error");
    }
  }
}
