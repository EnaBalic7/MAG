import 'package:flutter/material.dart';
import 'package:mag_user/providers/rating_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/anime_indicator.dart';
import '../providers/anime_list_provider.dart';
import '../providers/anime_watchlist_provider.dart';
import '../providers/listt_provider.dart';
import '../screens/constellation_screen.dart';
import '../screens/nebula_screen.dart';
import '../widgets/gradient_button.dart';
import '../models/anime.dart';
import '../models/search_result.dart';
import '../models/watchlist.dart';
import '../providers/watchlist_provider.dart';
import '../screens/anime_detail_screen.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/pagination_buttons.dart';
import 'constellation_form.dart';
import 'empty.dart';
import 'nebula_form.dart';

typedef FetchPage = Future<SearchResult<Anime>> Function(
    Map<String, dynamic> filter);

class AnimeCards extends StatefulWidget {
  final int selectedIndex;
  final Future<SearchResult<Anime>> Function() fetchAnime;
  final Future<Map<String, dynamic>> Function()? getFilter;
  final FetchPage fetchPage;
  Map<String, dynamic> filter;
  int page;
  int pageSize;

  AnimeCards({
    Key? key,
    required this.selectedIndex,
    required this.fetchAnime,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
    this.getFilter,
  }) : super(key: key);

  @override
  State<AnimeCards> createState() => _AnimeCardsState();
}

class _AnimeCardsState extends State<AnimeCards>
    with AutomaticKeepAliveClientMixin<AnimeCards> {
  late Future<SearchResult<Anime>> _animeFuture;
  final ScrollController _scrollController = ScrollController();
  late WatchlistProvider _watchlistProvider;
  late SearchResult<Watchlist> _watchlist;
  late int watchlistId;
  late AnimeWatchlistProvider _animeWatchlistProvider;
  late final ListtProvider _listtProvider;
  late final AnimeListProvider _animeListProvider;
  late final RatingProvider _ratingProvider;

  int totalItems = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(AnimeCards oldWidget) {
    // Check if filter has changed
    if (widget.filter != oldWidget.filter) {
      _animeFuture = widget.fetchAnime();
      setTotalItems();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _animeFuture = widget.fetchAnime();
    _watchlistProvider = context.read<WatchlistProvider>();
    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();
    _listtProvider = context.read<ListtProvider>();
    _animeListProvider = context.read<AnimeListProvider>();
    _ratingProvider = context.read<RatingProvider>();

    getWatchlistId();

    setTotalItems();

    _animeListProvider.addListener(() {
      setTotalItems();
    });

    _ratingProvider.addListener(_listener);

    super.initState();
  }

  @override
  void dispose() {
    _ratingProvider.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (mounted) {
      setState(() {
        _animeFuture = widget.fetchAnime();
      });
    }
  }

  void getWatchlistId() async {
    _watchlist = await _watchlistProvider
        .get(filter: {"userId": "${LoggedUser.user!.id}"});

    /// If zero, it means user has no watchlist yet
    watchlistId = (_watchlist.count == 1) ? _watchlist.result.first.id! : 0;
  }

  void setTotalItems() async {
    var animeResult = await _animeFuture;
    if (mounted) {
      setState(() {
        totalItems = animeResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<SearchResult<Anime>>(
        future: _animeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Center(
                child: Wrap(
                  children: List.generate(6, (_) => const AnimeIndicator()),
                ),
              ),
            );
            // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var animeList = snapshot.data!.result;
            return SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildAnimeCards(animeList),
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
          _animeFuture = Future.value(result);
          widget.page = requestedPage;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  List<Widget> _buildAnimeCards(List<Anime> animeList) {
    return List.generate(
      animeList.length,
      (index) => _buildAnimeCard(animeList[index]),
    );
  }

  Widget _buildAnimeCard(Anime anime) {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width * 0.44;
    double? cardHeight = screenSize.height * 0.3;

    double topPadding = cardHeight * 0.1 < 23.4 ? 10 : 0;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
        color: Palette.darkPurple,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnimeDetailScreen(
                        anime: anime,
                        selectedIndex: widget.selectedIndex,
                      ),
                    ));
                  },
                  child: (anime.imageUrl != null)
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            anime.imageUrl!,
                            width: cardWidth,
                            height: cardHeight * 0.85,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        )
                      : SizedBox(
                          width: cardWidth,
                          height: cardHeight * 0.85,
                        ),
                ),
                Positioned(
                  bottom: (cardHeight * 0.1 < 23.4)
                      ? -(cardHeight * 0.025)
                      : (cardHeight * 0.015),
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: cardHeight * 0.135,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildStarContainer(cardWidth, cardHeight, anime),
                        buildTrailingStarContainer(
                            cardWidth, cardHeight, anime),
                        buildNebulaContainer(cardWidth, cardHeight, anime),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimeDetailScreen(
                  anime: anime,
                  selectedIndex: widget.selectedIndex,
                ),
              ));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 10, left: 8, right: 8, top: topPadding),
              child: Text(
                anime.titleEn!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStarContainer(double cardWidth, double cardHeight, Anime anime) {
    return Container(
      width: cardWidth * 0.28,
      height: cardHeight * 0.1,
      decoration: BoxDecoration(
        color: Palette.darkPurple.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildStarIcon(cardHeight * 0.1 < 23.4 ? 12 : 16),
            Text("${anime.score}",
                style:
                    const TextStyle(fontSize: 11, color: Palette.starYellow)),
          ],
        ),
      ),
    );
  }

  Widget buildTrailingStarContainer(
      double cardWidth, double cardHeight, Anime anime) {
    return GestureDetector(
      onTap: () async {
        var constellations = await _listtProvider
            .get(filter: {"UserId": "${LoggedUser.user!.id}"});

        if (constellations.count == 0) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    insetPadding: const EdgeInsets.all(17),
                    alignment: Alignment.center,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Palette.darkPurple,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Palette.lightPurple.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Empty(
                                text: Text("Your Constellation is empty."),
                                screen: ConstellationScreen(selectedIndex: 3),
                                child: Text("Make Stars")),
                          ],
                        )));
              });
        } else if (constellations.count > 0) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConstellationForm(anime: anime);
              });
        }
      },
      child: Container(
        width: cardWidth * 0.28,
        height: cardHeight * 0.1,
        decoration: BoxDecoration(
          color: Palette.darkPurple.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildStarTrailIcon(cardHeight * 0.1 < 23.4 ? 15 : 21),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNebulaContainer(
      double cardWidth, double cardHeight, Anime anime) {
    return GestureDetector(
      onTap: () async {
        var animeWatchlist = await _animeWatchlistProvider
            .get(filter: {"WatchlistId": watchlistId, "AnimeId": anime.id});
        if (animeWatchlist.result.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                insetPadding: const EdgeInsets.all(17),
                alignment: Alignment.center,
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Palette.darkPurple,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Palette.lightPurple.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                          "You already added this anime to your Nebula."),
                      GradientButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const NebulaScreen(
                                        selectedIndex: 1,
                                      )));
                        },
                        borderRadius: 50,
                        width: 130,
                        paddingTop: 10,
                        height: 30,
                        gradient: Palette.buttonGradient,
                        child: const Text("Go to Nebula",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return NebulaForm(
                anime: anime,
                watchlistId: watchlistId,
              );
            },
          );
        }
      },
      child: Container(
        width: cardWidth * 0.28,
        height: cardHeight * 0.1,
        decoration: BoxDecoration(
          color: Palette.darkPurple.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                left: 8,
                child: buildNebulaIcon(
                    size: cardHeight * 0.1 < 23.4 ? 15 : 20,
                    returnIconData: false),
              ),
              Positioned(
                left: 22,
                child: buildSparklePlusIcon(cardHeight * 0.1 < 23.4 ? 9 : 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
