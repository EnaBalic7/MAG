import 'package:flutter/material.dart';
import 'package:mag_user/models/anime.dart';
import 'package:mag_user/providers/rating_provider.dart';
import 'package:mag_user/screens/anime_detail_screen.dart';
import 'package:mag_user/widgets/pagination_buttons.dart';
import 'package:provider/provider.dart';

import '../models/anime_watchlist.dart';
import '../models/rating.dart';
import '../models/search_result.dart';
import '../providers/anime_watchlist_provider.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import 'circular_progress_indicator.dart';
import 'nebula_form.dart';

typedef FetchPage = Future<SearchResult<AnimeWatchlist>> Function(
    Map<String, dynamic> filter);

class NebulaCards extends StatefulWidget {
  final int selectedIndex;
  final Future<SearchResult<AnimeWatchlist>> Function() fetch;
  final FetchPage fetchPage;
  final Map<String, dynamic> filter;
  int page;
  int pageSize;
  NebulaCards({
    Key? key,
    required this.selectedIndex,
    required this.fetch,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
  }) : super(key: key);

  @override
  State<NebulaCards> createState() => _NebulaCardsState();
}

class _NebulaCardsState extends State<NebulaCards>
    with AutomaticKeepAliveClientMixin<NebulaCards> {
  late Future<SearchResult<AnimeWatchlist>> _animeWatchlistFuture;
  late AnimeWatchlistProvider _animeWatchlistProvider;
  final ScrollController _scrollController = ScrollController();
  late RatingProvider _ratingProvider;
  int totalItems = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _animeWatchlistFuture = widget.fetch();
    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();
    _ratingProvider = context.read<RatingProvider>();

    _animeWatchlistProvider.addListener(() {
      _reloadData();
    });

    setTotalItems();

    super.initState();
  }

  void _reloadData() {
    if (mounted) {
      setState(() {
        _animeWatchlistFuture = _animeWatchlistProvider.get(filter: {
          ...widget.filter,
          "Page": "${widget.page}",
          "PageSize": "${widget.pageSize}"
        });
      });
    }
  }

  void setTotalItems() async {
    var animeResult = await _animeWatchlistFuture;
    if (mounted) {
      setState(() {
        totalItems = animeResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchResult<AnimeWatchlist>>(
        future: _animeWatchlistFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var animeWatchlists = snapshot.data!.result;
            return SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildNebulaCards(animeWatchlists),
                    ),
                    MyPaginationButtons(
                      page: widget.page,
                      pageSize: widget.pageSize,
                      totalItems: totalItems,
                      fetchPage: fetchPage,
                      hasSearch: false,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await widget.fetchPage({
        ...widget.filter,
        "Page": "$requestedPage",
        "PageSize": "${widget.pageSize}",
      });

      if (mounted) {
        setState(() {
          _animeWatchlistFuture = Future.value(result);
          widget.page = requestedPage;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  List<Widget> _buildNebulaCards(List<AnimeWatchlist> animeWatchlists) {
    return List.generate(
      animeWatchlists.length,
      (index) => _buildNebulaCard(animeWatchlists[index]),
    );
  }

  Widget _buildNebulaCard(AnimeWatchlist animeWatchlist) {
    Size screenSize = MediaQuery.of(context).size;
    double containerWidth = screenSize.width;
    double containerHeight = screenSize.height * 0.15;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimeDetailScreen(
                      anime: animeWatchlist.anime!,
                      selectedIndex: widget.selectedIndex,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          //constraints: BoxConstraints(maxHeight: 200),
          width: containerWidth,
          height: containerHeight,
          decoration:
              BoxDecoration(color: Palette.buttonPurple.withOpacity(0.4)),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                animeWatchlist.anime!.imageUrl!,
                fit: BoxFit.cover,
                width: containerWidth * 0.25,
                height: containerHeight,
                // width: 100,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: containerWidth * 0.6),
                              child: Text("${animeWatchlist.anime?.titleEn}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ),
                            Text(
                                "${animeWatchlist.anime!.season} ${animeWatchlist.anime!.beginAir?.year.toString()}",
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return NebulaForm(
                                    anime: animeWatchlist.anime!,
                                    animeWatchlist: animeWatchlist,
                                  );
                                },
                              );
                            },
                            child: buildEditIcon(30)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            buildStarIcon(20),
                            _buildRating(animeWatchlist)
                          ],
                        ),
                        Text(
                            "Progress: ${animeWatchlist.progress}/${animeWatchlist.anime!.episodesNumber}",
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildRating(AnimeWatchlist animeWatchlist) {
    return FutureBuilder<SearchResult<Rating>>(
        future: _ratingProvider.get(filter: {
          "UserId": "${LoggedUser.user!.id}",
          "AnimeId": "${animeWatchlist.anime!.id}"
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(
              height: 10,
              width: 10,
              strokeWidth: 2,
            ); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            Rating? rating;
            if (snapshot.data!.count == 1) {
              rating = snapshot.data!.result.single;
            }

            return (rating?.ratingValue != null)
                ? Text("${rating?.ratingValue}",
                    style: const TextStyle(color: Palette.starYellow))
                : const Text("-", style: TextStyle(color: Palette.starYellow));
          }
        });
  }
}
