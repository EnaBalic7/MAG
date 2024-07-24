import 'dart:convert';

import 'package:mag_user/models/search_result.dart';
import 'package:mag_user/utils/util.dart';

import '../models/popular_anime_data.dart';
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

  Future<SearchResult<Anime>> getRecommendedAnime() async {
    int loggedUserId = LoggedUser.user!.id!;

    var url = "${BaseProvider.baseUrl}$_endpoint/Recommend/$loggedUserId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      SearchResult<Anime> result = SearchResult<Anime>();
      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }
}
