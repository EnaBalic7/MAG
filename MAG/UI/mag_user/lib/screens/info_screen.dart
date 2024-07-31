import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/anime_watchlist.dart';
import '../models/preferred_genre.dart';
import '../models/rating.dart';
import '../providers/anime_watchlist_provider.dart';
import '../providers/preferred_genre_provider.dart';
import '../providers/rating_provider.dart';
import '../utils/icons.dart';
import '../widgets/gradient_button.dart';
import '../widgets/preferred_genres_form.dart';
import '../widgets/separator.dart';
import '../models/genre.dart';
import '../models/search_result.dart';
import '../models/watchlist.dart';
import '../providers/genre_provider.dart';
import '../providers/watchlist_provider.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final WatchlistProvider _watchlistProvider;
  late Future<SearchResult<Watchlist>> _watchlistFuture;
  late final AnimeWatchlistProvider _animeWatchlistProvider;
  late final RatingProvider _ratingProvider;
  late Future<SearchResult<Rating>> _ratingFuture;
  late final PreferredGenreProvider _preferredGenreProvider;
  late Future<SearchResult<PreferredGenre>> _prefGenresFuture;
  late final GenreProvider _genreProvider;
  late final Future<SearchResult<Genre>> _genreFuture;

  @override
  void initState() {
    _watchlistProvider = context.read<WatchlistProvider>();

    _watchlistFuture =
        _watchlistProvider.get(filter: {"UserId": "${LoggedUser.user!.id}"});

    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();
    _ratingProvider = context.read<RatingProvider>();
    _ratingFuture =
        _ratingProvider.get(filter: {"UserId": "${LoggedUser.user!.id}"});

    _genreProvider = context.read<GenreProvider>();
    _genreFuture = _genreProvider.get(filter: {"SortAlphabetically": true});

    _preferredGenreProvider = context.read<PreferredGenreProvider>();
    _prefGenresFuture = _preferredGenreProvider
        .get(filter: {"UserId": "${LoggedUser.user!.id}"});

    _preferredGenreProvider.addListener(() {
      _updatePreferredGenres();
    });

    super.initState();
  }

  _updatePreferredGenres() {
    if (mounted) {
      setState(() {
        _prefGenresFuture = _preferredGenreProvider
            .get(filter: {"UserId": "${LoggedUser.user!.id}"});
      });
    }
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Preferred genres",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 8),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const PreferredGenresForm();
                            });
                      },
                      child: buildEditIcon(24)),
                ],
              ),
              _buildPrefGenres(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrefGenres() {
    return FutureBuilder<SearchResult<Genre>>(
        future: _genreFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var genres = snapshot.data!.result;

            return FutureBuilder<SearchResult<PreferredGenre>>(
              future: _prefGenresFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const MyProgressIndicator(); // Loading state
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Error state
                } else {
                  // Data loaded successfully
                  var preferredGenres = snapshot.data!.result;

                  var genresToDisplay = genres
                      .where((genre) => preferredGenres
                          .any((prefGenre) => prefGenre.genreId == genre.id))
                      .map((genre) => genre.name!);

                  return Wrap(
                    spacing: 8,
                    children: [
                      ...genresToDisplay.map((genreName) {
                        return GradientButton(
                          gradient: Palette.navGradient4,
                          contentPaddingBottom: 2,
                          contentPaddingLeft: 5,
                          contentPaddingRight: 5,
                          contentPaddingTop: 2,
                          borderRadius: 50,
                          child: Text(
                            genreName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Palette.lightPurple),
                          ),
                        );
                      })
                    ],
                  );
                }
              },
            );
          }
        });
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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const Text("Total Anime in Nebula",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  _buildTotal(watchlist),
                  const SizedBox(height: 30),
                  const Text("Completed Anime",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  _buildCompleted(watchlist),
                  const SizedBox(height: 30),
                  const Text("Mean Score",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  _buildMean(),
                  const SizedBox(height: 30)
                ],
              ),
            );
          }
        });
  }

  Widget _buildTotal(SearchResult<Watchlist> watchlist) {
    if (watchlist.count == 1) {
      return FutureBuilder<SearchResult<AnimeWatchlist>>(
          future: _animeWatchlistProvider
              .get(filter: {"WatchlistId": "${watchlist.result[0].id}"}),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyProgressIndicator(
                height: 19,
                width: 19,
                strokeWidth: 3,
              ); // Loading state
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Error state
            } else {
              // Data loaded successfully
              var animeWatchlistData = snapshot.data!;
              int dataCount = animeWatchlistData.count;

              return Text(
                "$dataCount",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.turquoiseLight),
              );
            }
          });
    }
    return const Text(
      "0",
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Palette.turquoiseLight),
    );
  }

  Widget _buildCompleted(SearchResult<Watchlist> watchlist) {
    if (watchlist.count == 1) {
      return FutureBuilder<SearchResult<AnimeWatchlist>>(
          future: _animeWatchlistProvider
              .get(filter: {"WatchlistId": "${watchlist.result[0].id}"}),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyProgressIndicator(
                height: 19,
                width: 19,
                strokeWidth: 3,
              ); // Loading state
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Error state
            } else {
              // Data loaded successfully
              var animeWatchlistData = snapshot.data!.result
                  .where((element) => element.watchStatus == "Completed");
              int dataCount = animeWatchlistData.length;

              return Text(
                "$dataCount",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.rose),
              );
            }
          });
    }

    return const Text(
      "0",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Palette.rose,
      ),
    );
  }

  Widget _buildMean() {
    return FutureBuilder<SearchResult<Rating>>(
        future: _ratingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(
              height: 19,
              width: 19,
              strokeWidth: 3,
            ); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var ratingData = snapshot.data!;

            if (ratingData.result.isNotEmpty) {
              int sum = ratingData.result
                  .map((rating) => rating.ratingValue!)
                  .reduce((value, element) => value + element);

              double meanScore = sum / ratingData.result.length;
              String meanScoreRounded = meanScore.toStringAsFixed(2);

              return Text(
                meanScoreRounded,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Palette.lightYellow,
                ),
              );
            } else {
              return const Text(
                "-",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.lightYellow),
              );
            }
          }
        });
  }
}
