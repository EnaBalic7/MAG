import 'package:flutter/material.dart';
import 'package:mag_user/models/anime.dart';
import 'package:mag_user/models/search_result.dart';
import 'package:mag_user/models/watchlist.dart';
import 'package:mag_user/providers/anime_watchlist_provider.dart';
import 'package:mag_user/providers/listt_provider.dart';
import 'package:mag_user/providers/watchlist_provider.dart';
import 'package:mag_user/screens/anime_detail_screen.dart';
import 'package:mag_user/screens/constellation_screen.dart';
import 'package:mag_user/screens/nebula_screen.dart';
import 'package:mag_user/utils/colors.dart';
import 'package:mag_user/utils/icons.dart';
import 'package:mag_user/utils/util.dart';
import 'package:mag_user/widgets/constellation_form.dart';
import 'package:mag_user/widgets/empty.dart';
import 'package:mag_user/widgets/gradient_button.dart';
import 'package:mag_user/widgets/nebula_form.dart';
import 'package:provider/provider.dart';

class AnimeCard extends StatefulWidget {
  final Anime anime;
  final int selectedIndex;
  const AnimeCard(
      {super.key, required this.anime, required this.selectedIndex});

  @override
  State<AnimeCard> createState() => _AnimeCardState();
}

class _AnimeCardState extends State<AnimeCard> {
  late int watchlistId;
  late SearchResult<Watchlist> _watchlist;
  late WatchlistProvider _watchlistProvider;
  late AnimeWatchlistProvider _animeWatchlistProvider;
  late final ListtProvider _listtProvider;

  @override
  void initState() {
    _watchlistProvider = context.read<WatchlistProvider>();
    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();
    _listtProvider = context.read<ListtProvider>();
    getWatchlistId();

    super.initState();
  }

  void getWatchlistId() async {
    _watchlist = await _watchlistProvider
        .get(filter: {"userId": "${LoggedUser.user!.id}"});

    /// If zero, it means user has no watchlist yet
    watchlistId = (_watchlist.count == 1) ? _watchlist.result.first.id! : 0;
  }

  @override
  Widget build(BuildContext context) {
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
                        anime: widget.anime,
                        selectedIndex: widget.selectedIndex,
                      ),
                    ));
                  },
                  child: (widget.anime.imageUrl != null)
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            widget.anime.imageUrl!,
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
                  bottom: (cardHeight * 0.1 < 23.4) ? -(cardHeight * 0.025) : 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: cardHeight * 0.135,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildStarContainer(cardWidth, cardHeight, widget.anime),
                        buildTrailingStarContainer(
                            cardWidth, cardHeight, widget.anime),
                        buildNebulaContainer(
                            cardWidth, cardHeight, widget.anime),
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
                  anime: widget.anime,
                  selectedIndex: widget.selectedIndex,
                ),
              ));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 10, left: 8, right: 8, top: topPadding),
              child: Text(
                widget.anime.titleEn!,
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
          if (mounted) {
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
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Empty(
                                  text: Text("Your Constellation is empty."),
                                  screen: ConstellationScreen(selectedIndex: 3),
                                  child: Text("Make Stars",
                                      style: TextStyle(
                                          color: Palette.lightPurple))),
                            ],
                          )));
                });
          }
        } else if (constellations.count > 0) {
          if (mounted) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConstellationForm(anime: anime);
                });
          }
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
          if (mounted) {
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
                          "You already added this anime to your Nebula.",
                          textAlign: TextAlign.center,
                        ),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Palette.white)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          if (mounted) {
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
