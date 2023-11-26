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
      (index) => buildAnimeCard(animeList[index]),
    );
  }

  Widget buildAnimeCard(Anime anime) {
    return Container(
        width: 290,
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
                width: 290,
                height: 250,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                  child: Row(
                    children: [
                      buildStarIcon(15),
                      SizedBox(width: 3),
                      Text(anime.score.toString(),
                          style: TextStyle(
                              color: Palette.starYellow, fontSize: 11)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 0, right: 0, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AnimeDetailScreen(anime: anime)));
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            anime.titleEn!,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 7, left: 5, right: 5, bottom: 5),
                  child: GestureDetector(
                      onTap: () {
                        showConfirmationDialog(
                            context,
                            Icon(Icons.warning_rounded,
                                color: Palette.lightRed, size: 55),
                            Text("Are you sure you want to delete this anime?"),
                            () {
                          _animeProvider.delete(anime.id!);
                        });
                      },
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: buildTrashIcon(20))),
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
