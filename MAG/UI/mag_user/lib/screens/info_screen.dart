import 'package:flutter/material.dart';
import 'package:mag_user/models/anime_watchlist.dart';
import 'package:mag_user/providers/anime_watchlist_provider.dart';
import 'package:mag_user/widgets/separator.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';
import '../models/watchlist.dart';
import '../providers/watchlist_provider.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late WatchlistProvider _watchlistProvider;
  late Future<SearchResult<Watchlist>> _watchlistFuture;
  late AnimeWatchlistProvider _animeWatchlistProvider;

  @override
  void initState() {
    _watchlistProvider = context.read<WatchlistProvider>();

    _watchlistFuture =
        _watchlistProvider.get(filter: {"UserId": "${LoggedUser.user!.id}"});

    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildInfo(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MySeparator(
              width: screenSize.width * 0.7,
              paddingBottom: 20,
              opacity: 0.6,
              borderRadius: 50,
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Text("Preferred genres",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return FutureBuilder<SearchResult<Watchlist>>(
        future: _watchlistFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            SearchResult<Watchlist> watchlist = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text("Total Anime in Nebula",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  _buildTotal(watchlist),
                  const SizedBox(height: 30),
                  const Text("Completed Anime",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  _buildCompleted(),
                  const SizedBox(height: 30),
                  const Text("Mean Score",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  _buildMean(),
                  const SizedBox(height: 30)
                ],
              ),
            );
          }
        });
  }

  Widget _buildTotal(SearchResult<Watchlist> watchlist) {
    return FutureBuilder<SearchResult<AnimeWatchlist>>(
        future: _animeWatchlistProvider.get(filter: {"WatchlistId": ""}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully

            Rating? rating;
            if (snapshot.data!.result.isNotEmpty) {
              rating = snapshot.data!.result.single;
            }

            return _buildReviewCard(rating);
          }
        });
  }

  Widget _buildCompleted() {
    return Text("xxxx");
  }

  Widget _buildMean() {
    return Text("xxxx");
  }
}
