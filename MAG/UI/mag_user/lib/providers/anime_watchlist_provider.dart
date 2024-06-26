import '../models/anime_watchlist.dart';
import '../providers/base_provider.dart';

class AnimeWatchlistProvider extends BaseProvider<AnimeWatchlist> {
  AnimeWatchlistProvider() : super("AnimeWatchlist");

  @override
  AnimeWatchlist fromJson(data) {
    return AnimeWatchlist.fromJson(data);
  }
}
