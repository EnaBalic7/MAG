import 'package:flutter/material.dart';
import 'package:mag_user/models/anime.dart';
import 'package:mag_user/providers/anime_list_provider.dart';
import 'package:mag_user/providers/listt_provider.dart';
import 'package:mag_user/utils/icons.dart';
import 'package:mag_user/widgets/star_form.dart';
import 'package:provider/provider.dart';

import '../models/anime_list.dart';
import '../models/listt.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/pagination_buttons.dart';
import 'circular_progress_indicator.dart';

class ConstellationCards extends StatefulWidget {
  ConstellationCards({Key? key}) : super(key: key);

  @override
  State<ConstellationCards> createState() => _ConstellationCardsState();
}

class _ConstellationCardsState extends State<ConstellationCards> {
  late Future<SearchResult<Listt>> _listFuture;
  late final ListtProvider _listProvider;
  late Future<SearchResult<AnimeList>> _animeListFuture;
  late final AnimeListProvider _animeListProvider;
  final ScrollController _scrollController = ScrollController();

  int page = 0;
  int pageSize = 6;
  int totalItems = 0;

  @override
  void initState() {
    _listProvider = context.read<ListtProvider>();
    _listFuture = _listProvider.get(
      filter: {
        "NewestFirst": "true",
        "Page": "$page",
        "PageSize": "$pageSize",
      },
    );

    _animeListProvider = context.read<AnimeListProvider>();

    _listProvider.addListener(() {
      _reloadData();
    });

    setTotalItems();

    super.initState();
  }

  void _reloadData() {
    if (mounted) {
      setState(() {
        _listFuture = _listProvider.get(filter: {
          "NewestFirst": "true",
          "Page": "$page",
          "PageSize": "$pageSize",
        });
      });
    }
  }

  void setTotalItems() async {
    var listResult = await _listFuture;
    if (mounted) {
      setState(() {
        totalItems = listResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchResult<Listt>>(
        future: _listFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var lists = snapshot.data!.result;
            return SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildListCards(lists),
                    ),
                    MyPaginationButtons(
                      page: page,
                      pageSize: pageSize,
                      totalItems: totalItems,
                      fetchPage: fetchPage,
                      hasSearch: true,
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
      var result = await _listProvider.get(
        filter: {
          "NewestFirst": "true",
          "Page": "$requestedPage",
          "PageSize": "$pageSize",
        },
      );

      if (mounted) {
        setState(() {
          _listFuture = Future.value(result);
          page = requestedPage;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  List<Widget> _buildListCards(List<Listt> lists) {
    return List.generate(
      lists.length,
      (index) => _buildListCard(lists[index]),
    );
  }

  Widget _buildListCard(Listt list) {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width * 0.45;
    double? cardHeight = screenSize.height * 0.2;

    return FutureBuilder<SearchResult<AnimeList>>(
        future: _animeListProvider.get(
          filter: {
            "ListId": "${list.id}",
            "IncludeAnime": "true",
            "GetRandom": "true",
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var animeListObject = snapshot.data!.result;

            return Container(
              height: cardHeight,
              width: cardWidth,
              margin: const EdgeInsets.all(7),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Opacity(
                      opacity: 0.7,
                      child: _buildCoverPhoto(
                          cardWidth, cardHeight, animeListObject),
                    ),
                  ),
                  Center(
                      child: Container(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 5,
                      bottom: 5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.darkPurple.withOpacity(0.8)),
                    child: Text("${list.name}",
                        style: const TextStyle(
                          fontSize: 17,
                        )),
                  )),
                  Positioned(right: 0, child: _buildPopupMenu(list)),
                ],
              ),
            );
          }
        });
  }

  Widget _buildCoverPhoto(
      double cardWidth, double cardHeight, List<AnimeList> animeListObject) {
    if (animeListObject.isEmpty) {
      return Container(
        decoration: BoxDecoration(color: Palette.lightPurple.withOpacity(0.3)),
      );
    }
    return Image.network(
      animeListObject.single.anime!.imageUrl!,
      width: cardWidth,
      height: cardHeight,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }

  Widget _buildPopupMenu(Listt list) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Palette.darkPurple.withOpacity(0.8)),
      child: PopupMenuButton<String>(
        tooltip: "Actions",
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
        ),
        icon: const Icon(Icons.more_horiz_rounded),
        splashRadius: 1,
        padding: EdgeInsets.zero,
        color: const Color.fromRGBO(50, 48, 90, 1),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            child: ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              hoverColor: Palette.lightPurple.withOpacity(0.1),
              leading:
                  const Icon(Icons.edit_rounded, color: Palette.lightPurple),
              title: const Text('Rename',
                  style: TextStyle(color: Palette.lightPurple)),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StarForm(
                      initialValue: list.name,
                      listId: list.id,
                    );
                  },
                );
              },
            ),
          ),
          PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            child: ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              hoverColor: Palette.lightRed.withOpacity(0.1),
              leading: buildTrashIcon(24),
              title: const Text('Delete',
                  style: TextStyle(color: Palette.lightRed)),
              onTap: () {
                Navigator.pop(context);
                showConfirmationDialog(
                    context,
                    const Icon(Icons.warning_rounded,
                        color: Palette.lightRed, size: 55),
                    const Text(
                      "Are you sure you want to delete this Star?",
                      textAlign: TextAlign.center,
                    ), () async {
                  _listProvider.delete(list.id!);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
