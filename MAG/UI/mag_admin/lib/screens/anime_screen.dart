import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/anime_provider.dart';
import '../providers/genre_anime_provider.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/master_screen.dart';
import '../widgets/pagination_buttons.dart';
import '../models/anime.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../widgets/circular_progress_indicator.dart';
import 'anime_detail_screen.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  late AnimeProvider _animeProvider;
  late GenreAnimeProvider _genreAnimeProvider;
  SearchResult<Anime>? result;
  late Future<SearchResult<Anime>> _animeFuture;
  final TextEditingController _animeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int page = 0;
  int pageSize = 8;
  int totalItems = 0;
  bool isSearching = false;

  @override
  void initState() {
    _animeProvider = context.read<AnimeProvider>();
    _genreAnimeProvider = context.read<GenreAnimeProvider>();

    _animeProvider.addListener(() {
      _reloadAnimeList();
      setTotalItems();
    });
    _genreAnimeProvider.addListener(() {
      _reloadAnimeList();
      setTotalItems();
    });

    _animeFuture = _animeProvider.get(filter: {
      "GenresIncluded": "true",
      "NewestFirst": "true",
      "Page": "$page",
      "PageSize": "$pageSize"
    });

    setTotalItems();

    super.initState();
  }

  void setTotalItems() async {
    var animeResult = await _animeFuture;
    if (mounted) {
      setState(() {
        totalItems = animeResult.count;
      });
    }
  }

  void _reloadAnimeList() {
    if (mounted) {
      setState(() {
        _animeFuture = _animeProvider.get(filter: {
          "GenresIncluded": "true",
          "NewestFirst": "true",
          "Page": "$page",
          "PageSize": "$pageSize"
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      titleWidget: Row(
        children: [
          buildAnimeIcon(28),
          const SizedBox(width: 5),
          const Text("Anime"),
        ],
      ),
      showFloatingActionButton: true,
      floatingButtonOnPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AnimeDetailScreen()));
      },
      showSearch: true,
      onSubmitted: _search,
      controller: _animeController,
      child: FutureBuilder<SearchResult<Anime>>(
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
                          fetchPage: fetchPage),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await _animeProvider.get(
        filter: {
          "FTS": isSearching ? _animeController.text : null,
          "GenresIncluded": "true",
          "NewestFirst": "true",
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
      if (mounted) {
        showErrorDialog(context, e);
      }
    }
  }

  void _search(String searchText) async {
    try {
      var result = await _animeProvider.get(filter: {
        "FTS": searchText,
        "GenresIncluded": "true",
        "NewestFirst": "true",
        "Page": "0",
        "PageSize": "$pageSize",
      });

      if (mounted) {
        setState(() {
          _animeFuture = Future.value(result);
          isSearching = true;
          totalItems = result.count;
          page = 0;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        showErrorDialog(context, e);
      }
    }
  }

  List<Widget> _buildAnimeCards(List<Anime> animeList) {
    return List.generate(
      animeList.length,
      (index) => _buildAnimeCard(animeList[index]),
    );
  }

  Widget _buildPopupMenu(Anime anime) {
    return PopupMenuButton<String>(
      tooltip: "Actions",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
      ),
      icon: const Icon(Icons.more_vert_rounded),
      splashRadius: 1,
      padding: EdgeInsets.zero,
      color: const Color.fromRGBO(50, 48, 90, 1),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightPurple.withOpacity(0.1),
            leading: const Icon(Icons.text_snippet_rounded,
                color: Palette.lightPurple),
            title: const Text('See details',
                style: TextStyle(color: Palette.lightPurple)),
            subtitle: Text('See more information about this anime',
                style: TextStyle(color: Palette.lightPurple.withOpacity(0.5))),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AnimeDetailScreen(anime: anime)));
            },
          ),
        ),
        PopupMenuItem<String>(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightRed.withOpacity(0.1),
            leading: buildTrashIcon(24),
            title:
                const Text('Delete', style: TextStyle(color: Palette.lightRed)),
            subtitle: Text('Delete permanently',
                style: TextStyle(color: Palette.lightRed.withOpacity(0.5))),
            onTap: () {
              Navigator.pop(context);
              showConfirmationDialog(
                  context,
                  const Icon(Icons.warning_rounded,
                      color: Palette.lightRed, size: 55),
                  const Text("Are you sure you want to delete this anime?"),
                  () async {
                _animeProvider.delete(anime.id!);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnimeCard(Anime anime) {
    return Container(
        width: 300,
        height: 453,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 0, bottom: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
        child: Column(
          children: [
            (anime.imageUrl != null)
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      anime.imageUrl!,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  )
                : const SizedBox(
                    width: 300,
                    height: 300,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, left: 10, right: 0, bottom: 13),
                  child: Row(
                    children: [
                      buildStarIcon(17),
                      const SizedBox(width: 3),
                      Text(anime.score.toString(),
                          style: const TextStyle(
                              color: Palette.starYellow, fontSize: 13)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 5, right: 0, top: 5),
                      child: Text(
                        anime.titleEn!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, left: 0, right: 0, bottom: 0),
                  child: _buildPopupMenu(anime),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Text(anime.synopsis!),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
