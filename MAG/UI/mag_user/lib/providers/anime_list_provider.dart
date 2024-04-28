import 'dart:convert';

import '../providers/base_provider.dart';
import '../models/anime_list.dart';

class AnimeListProvider extends BaseProvider<AnimeList> {
  final String _endpoint = "AnimeList";
  AnimeListProvider() : super("AnimeList");

  @override
  AnimeList fromJson(data) {
    return AnimeList.fromJson(data);
  }

  Future<bool> updateListsForAnime(
      int animeId, List<AnimeList> newLists) async {
    var url = "${BaseProvider.baseUrl}$_endpoint/UpdateLists/$animeId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(newLists);
    var response = await http!.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      notifyListeners();
      return true;
    } else {
      throw Exception("Unknown error");
    }
  }
}
