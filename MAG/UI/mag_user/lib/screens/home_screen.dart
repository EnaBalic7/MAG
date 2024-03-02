import 'package:flutter/material.dart';
import 'package:mag_user/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/search_result.dart';
import '../providers/anime_provider.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/pagination_buttons.dart';
import 'anime_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  HomeScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimeProvider _animeProvider;
  late TabController _tabController;
  late Future<SearchResult<Anime>> _animeFuture;
  final ScrollController _scrollController = ScrollController();

  int page = 0;
  int pageSize = 8;
  int totalItems = 0;

  @override
  void initState() {
    _animeProvider = context.read<AnimeProvider>();
    _tabController = TabController(length: 2, vsync: this);

    _animeFuture = _animeProvider.get(filter: {
      "GenresIncluded": "true",
      "NewestFirst": "false",
      "Page": "$page",
      "PageSize": "$pageSize"
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      selectedIndex: widget.selectedIndex,
      showTabBar: true,
      tabController: _tabController,
      title: "Home",
      tabs: const [
        Text(
          "Top Anime",
        ),
        Text(
          "Recommended",
        )
      ],
      child: TabBarView(controller: _tabController, children: [
        _buildTopAnime(),
        _buildRecommendedAnime(),
      ]),
    );
  }

  Widget _buildRecommendedAnime() {
    return const Text("Recommended");
  }

  Widget _buildTopAnime() {
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
                      page: page,
                      pageSize: pageSize,
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

  List<Widget> _buildAnimeCards(List<Anime> animeList) {
    return List.generate(
      animeList.length,
      (index) => _buildAnimeCard(animeList[index]),
    );
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await _animeProvider.get(
        filter: {
          "GenresIncluded": "true",
          "NewestFirst": "false",
          "Page": "$requestedPage",
          "PageSize": "$pageSize",
        },
      );

      if (mounted) {
        setState(() {
          _animeFuture = Future.value(result);
          page = requestedPage;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  Widget _buildAnimeCard(Anime anime) {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width * 0.44;
    double? cardHeight = screenSize.height * 0.3;
    return Container(
        width: cardWidth,
        height: cardHeight,
        margin: const EdgeInsets.only(top: 7, left: 7, right: 7, bottom: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
        child: Column(
          children: [
            Stack(children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnimeDetailScreen(
                            anime: anime,
                            selectedIndex: widget.selectedIndex,
                          )));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
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
                top: cardHeight * 0.75,
                child: SizedBox(
                  width: cardWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: cardWidth * 0.28,
                          height: cardHeight * 0.1,
                          decoration: BoxDecoration(
                            color: Palette.darkPurple.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 1.5, left: 1, right: 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                buildStarIcon(16),
                                const Text("7.14",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Palette.starYellow))
                              ],
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          showInfoDialog(context, Text("Star~"),
                              Text("You clicked on Trailing star!"));
                        },
                        child: Container(
                            width: cardWidth * 0.28,
                            height: cardHeight * 0.1,
                            decoration: BoxDecoration(
                              color: Palette.darkPurple.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 1.5, left: 1, right: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  buildStarTrailIcon(22),
                                ],
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          showInfoDialog(context, Text("Nebula~"),
                              Text("You clicked on Nebula!"));
                        },
                        child: Container(
                            width: cardWidth * 0.28,
                            height: cardHeight * 0.1,
                            decoration: BoxDecoration(
                              color: Palette.darkPurple.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 1.5, left: 1, right: 1),
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Positioned(
                                    left: 8,
                                    child: buildNebulaIcon(
                                        size: 20, returnIconData: false),
                                  ),
                                  Positioned(
                                    left: 22,
                                    child: buildSparklePlusIcon(12),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnimeDetailScreen(
                          anime: anime,
                          selectedIndex: widget.selectedIndex,
                        )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 0, left: 8, right: 8, top: 10),
                      child: Container(
                        alignment: Alignment.center,
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
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
