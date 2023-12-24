import 'package:flutter/material.dart';
import 'package:mag_admin/providers/anime_provider.dart';
import 'package:mag_admin/providers/genre_anime_provider.dart';
import 'package:mag_admin/utils/icons.dart';
import 'package:mag_admin/utils/util.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';
import '../models/anime.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../widgets/gradient_button.dart';
import 'anime_detail_screen.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({Key? key}) : super(key: key);

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  late AnimeProvider _animeProvider;
  late GenreAnimeProvider _genreAnimeProvider;
  SearchResult<Anime>? result;
  late Future<SearchResult<Anime>> _animeFuture;
  TextEditingController _animeController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  List<Anime> animeList = [];
  int page = 0;
  int pageSize = 8;
  int totalItems = 0;
  bool isSearching = false;

  @override
  void initState() {
    context.read<AnimeProvider>().addListener(() {
      _reloadAnimeList();
    });
    context.read<GenreAnimeProvider>().addListener(() {
      _reloadAnimeList();
    });

    _animeProvider = context.read<AnimeProvider>();
    _animeFuture = _animeProvider.get(filter: {
      "GenresIncluded": "true",
      "Page": "$page",
      "PageSize": "$pageSize"
    });

    setTotalItems();
    _genreAnimeProvider = context.read<GenreAnimeProvider>();

    super.initState();
  }

  void setTotalItems() async {
    var animeResult = await _animeFuture;
    setState(() {
      totalItems = animeResult.count;
    });
  }

  void _reloadAnimeList() {
    if (mounted) {
      setState(() {
        _animeFuture = context.read<AnimeProvider>().get(filter: {
          "GenresIncluded": "true",
          "Page": "$page",
          "PageSize": "$pageSize"
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Row(
        children: [
          buildAnimeIcon(28),
          SizedBox(width: 5),
          Text("Anime"),
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
              return CircularProgressIndicator(); // Loading state
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed:
                                    page > 0 ? () => fetchPage(page - 1) : null,
                                child: Icon(Icons.arrow_back_ios_rounded),
                              ),
                            ),
                            Text(
                                'Page ${page + 1} of ${(totalItems / 8).round()}'),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                onPressed: page + 1 == (totalItems / 8).round()
                                    ? null
                                    : () => fetchPage(page + 1),
                                child: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
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
          "Page": "$requestedPage",
          "PageSize": "$pageSize",
        },
      );

      setState(() {
        animeList = result.result;
        _animeFuture = Future.value(result);
        page = requestedPage;
        isSearching = false;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  void _search(String searchText) async {
    try {
      var result = await _animeProvider.get(filter: {
        "FTS": searchText,
        "GenresIncluded": "true",
        "Page": "0",
        "PageSize": "$pageSize",
      });

      setState(() {
        _animeFuture = Future.value(result);
        animeList = result.result;
        page = 0;
        isSearching = true;
      });
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

  Widget _buildPopupMenu(Anime anime) {
    return PopupMenuButton<String>(
      tooltip: "Actions",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
      ),
      icon: Icon(Icons.more_vert_rounded),
      splashRadius: 1,
      padding: EdgeInsets.zero,
      color: Color.fromRGBO(50, 48, 90, 1),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightPurple.withOpacity(0.1),
            leading:
                Icon(Icons.text_snippet_rounded, color: Palette.lightPurple),
            title: Text('See details',
                style: TextStyle(color: Palette.lightPurple)),
            subtitle: Text('See more information about this anime',
                style: TextStyle(color: Palette.lightPurple.withOpacity(0.5))),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AnimeDetailScreen(anime: anime)));
            },
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightRed.withOpacity(0.1),
            leading: buildTrashIcon(24),
            title: Text('Delete', style: TextStyle(color: Palette.lightRed)),
            subtitle: Text('Delete permanently',
                style: TextStyle(color: Palette.lightRed.withOpacity(0.5))),
            onTap: () {
              showConfirmationDialog(
                  context,
                  Icon(Icons.warning_rounded,
                      color: Palette.lightRed, size: 55),
                  Text("Are you sure you want to delete this anime?"),
                  () async {
                await _genreAnimeProvider.deleteByAnimeId(anime.id!);
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
        margin: EdgeInsets.only(top: 20, left: 20, right: 0, bottom: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image.network(
                anime.imageUrl!,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 13),
                  child: Row(
                    children: [
                      buildStarIcon(17),
                      SizedBox(width: 3),
                      Text(anime.score.toString(),
                          style: TextStyle(
                              color: Palette.starYellow, fontSize: 13)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 0, right: 0, top: 5),
                      child: Text(
                        anime.titleEn!,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
