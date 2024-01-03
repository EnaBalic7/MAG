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

  Future<bool> updateGenresForAnime(
      int animeId, List<GenreAnime> newGenres) async {
    var url = "${BaseProvider.baseUrl}$_endpoint/$animeId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(newGenres);
    var response = await http!.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      notifyListeners();
      return true;
    } else {
      throw Exception("Unknown error");
    }
  }
}
