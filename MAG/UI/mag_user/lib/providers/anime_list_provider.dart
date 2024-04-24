import '../providers/base_provider.dart';
import '../models/anime_list.dart';

class AnimeListProvider extends BaseProvider<AnimeList> {
  AnimeListProvider() : super("AnimeList");

  @override
  AnimeList fromJson(data) {
    return AnimeList.fromJson(data);
  }
}
