import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/watchlist_provider.dart';
import '../utils/util.dart';
import '../widgets/empty.dart';
import '../widgets/nebula_cards.dart';
import '../models/anime_watchlist.dart';
import '../models/search_result.dart';
import '../models/watchlist.dart';
import '../providers/anime_watchlist_provider.dart';
import '../widgets/nebula_indicator.dart';
import 'home_screen.dart';

class NebulaAllScreen extends StatefulWidget {
  final int selectedIndex;
  const NebulaAllScreen({super.key, required this.selectedIndex});

  @override
  State<NebulaAllScreen> createState() => _NebulaAllScreenState();
}

class _NebulaAllScreenState extends State<NebulaAllScreen> {
  late AnimeWatchlistProvider _animeWatchlistProvider;
  late WatchlistProvider _watchlistProvider;
  late SearchResult<Watchlist> _watchlist;

  int page = 0;
  int pageSize = 20;

  late final Map<String, dynamic> _filter;
  late Future<Map<String, dynamic>> _filterFuture;

  @override
  void initState() {
    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();
    _watchlistProvider = context.read<WatchlistProvider>();
    _filterFuture = getFilter();

    super.initState();
  }

  Future<Map<String, dynamic>> getFilter() async {
    _watchlist = await _watchlistProvider
        .get(filter: {"UserId": "${LoggedUser.user!.id}"});

    if (_watchlist.result.isNotEmpty) {
      _filter = {
        "WatchlistId": "${_watchlist.result[0].id}",
        "GenresIncluded": "true",
        "NewestFirst": "true",
      };
      return _filter;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _filterFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Center(
              child: Wrap(
                children: [
                  NebulaIndicator(),
                  NebulaIndicator(),
                  NebulaIndicator(),
                  NebulaIndicator(),
                  NebulaIndicator(),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final filter = snapshot.data!;

          if (filter.isNotEmpty) {
            return NebulaCards(
              selectedIndex: widget.selectedIndex,
              page: page,
              pageSize: pageSize,
              fetch: fetchAnime,
              fetchPage: fetchPage,
              filter: filter,
            );
          }
          return const Empty(
              text: Text("Nothing to be found here~"),
              screen: HomeScreen(selectedIndex: 0),
              child: Text("Explore Anime"));
        }
      },
    );
  }

  Future<SearchResult<AnimeWatchlist>> fetchAnime() {
    return _animeWatchlistProvider.get(filter: {
      ..._filter,
      "Page": "$page",
      "PageSize": "$pageSize",
    });
  }

  Future<SearchResult<AnimeWatchlist>> fetchPage(Map<String, dynamic> filter) {
    return _animeWatchlistProvider.get(filter: filter);
  }
}
