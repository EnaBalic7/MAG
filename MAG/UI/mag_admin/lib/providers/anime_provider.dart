import 'dart:convert';

import 'package:mag_admin/models/popular_anime_data.dart';

import '../providers/base_provider.dart';
import '../models/anime.dart';

class AnimeProvider extends BaseProvider<Anime> {
  final String _endpoint = "Anime";
  AnimeProvider() : super("Anime");

  @override
  Anime fromJson(data) {
    return Anime.fromJson(data);
  }

  Future<List<PopularAnimeData>> getMostPopularAnime() async {
    var url = "${BaseProvider.baseUrl}$_endpoint/GetMostPopularAnime";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      List<PopularAnimeData> result = [];

      for (var item in data) {
        result.add(PopularAnimeData(item["animeTitleEN"], item["animeTitleJP"],
            item["score"], item["numberOfRatings"]));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }
}
