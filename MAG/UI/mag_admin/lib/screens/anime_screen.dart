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

  @override
  void initState() {
    context.read<AnimeProvider>().addListener(() {
      _reloadAnimeList();
    });
    context.read<GenreAnimeProvider>().addListener(() {
      _reloadAnimeList();
    });
    super.initState();
  }

  void _reloadAnimeList() {
    if (mounted) {
      setState(() {
        _animeFuture = context
            .read<AnimeProvider>()
            .get(filter: {"GenresIncluded": "true"});
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _animeProvider = context.read<AnimeProvider>();
    _animeFuture = _animeProvider.get(filter: {"GenresIncluded": "true"});
    _genreAnimeProvider = context.read<GenreAnimeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
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
              child: Center(
                child: Wrap(
                  children: _buildAnimeCards(animeList),
                ),
              ),
            );
          }
        },
      ),
      title_widget: Text("Anime"),
    );
  }

  void _search(String searchText) async {
    var data = _animeProvider.get(filter: {'fts': _animeController.text});

    setState(() {
      _animeFuture = data;
    });
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
                height: 250,
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
