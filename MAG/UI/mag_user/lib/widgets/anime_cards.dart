import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/search_result.dart';
import '../models/watchlist.dart';
import '../providers/watchlist_provider.dart';
import '../screens/anime_detail_screen.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/pagination_buttons.dart';
import 'nebula_form.dart';

typedef FetchPage = Future<SearchResult<Anime>> Function(
    Map<String, dynamic> filter);

class AnimeCards extends StatefulWidget {
  final int selectedIndex;
  final Future<SearchResult<Anime>> Function() fetchAnime;
  final FetchPage fetchPage;
  final Map<String, dynamic> filter;
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

  int totalItems = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _animeFuture = widget.fetchAnime();
    _watchlistProvider = context.read<WatchlistProvider>();

    getWatchlistId();

    setTotalItems();

    super.initState();
  }

  void getWatchlistId() async {
    _watchlist = await _watchlistProvider
        .get(filter: {"userId": "${LoggedUser.user!.id}"});

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
    return FutureBuilder<SearchResult<Anime>>(
        future: _animeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
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
                  child: ClipRRect(
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
                        buildTrailingStarContainer(cardWidth, cardHeight),
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
    return GestureDetector(
      onTap: () {
        showInfoDialog(
            context, const Text("Star~"), const Text("You clicked on Star!"));
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
              buildStarIcon(cardHeight * 0.1 < 23.4 ? 12 : 16),
              Text("${anime.score}",
                  style:
                      const TextStyle(fontSize: 11, color: Palette.starYellow)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTrailingStarContainer(double cardWidth, double cardHeight) {
    return GestureDetector(
      onTap: () {
        showInfoDialog(context, const Text("Star~"),
            const Text("You clicked on Trailing star!"));
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
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return NebulaForm(
              anime: anime,
              watchlistId: watchlistId,
            );
          },
        );
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
