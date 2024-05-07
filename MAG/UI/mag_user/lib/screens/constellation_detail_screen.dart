import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mag_user/models/search_result.dart';
import 'package:mag_user/providers/anime_list_provider.dart';
import 'package:mag_user/screens/home_screen.dart';
import 'package:mag_user/utils/icons.dart';
import 'package:mag_user/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/anime_list.dart';
import '../models/listt.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_cards.dart';
import '../widgets/empty.dart';

class ConstellationDetailScreen extends StatefulWidget {
  final int selectedIndex;
  final Listt star;
  final List<AnimeList> animeListRandomObj;
  const ConstellationDetailScreen({
    Key? key,
    required this.selectedIndex,
    required this.star,
    required this.animeListRandomObj,
  }) : super(key: key);

  @override
  State<ConstellationDetailScreen> createState() =>
      _ConstellationDetailScreenState();
}

class _ConstellationDetailScreenState extends State<ConstellationDetailScreen> {
  late AnimeProvider _animeProvider;
  late AnimeListProvider _animeListProvider;
  late SearchResult<AnimeList> _animeList;

  int page = 0;
  int pageSize = 20;

  Map<String, dynamic> _filter = {};
  late Future<Map<String, dynamic>> _filterFuture;

  @override
  void initState() {
    _animeProvider = context.read<AnimeProvider>();
    _animeListProvider = context.read<AnimeListProvider>();
    _animeListProvider.addListener(_animeListListener);

    _filterFuture = getFilter();

    super.initState();
  }

  void _animeListListener() {
    if (mounted) {
      setState(() {
        _filterFuture = getFilter();
      });
    }
  }

  @override
  void dispose() {
    _animeListProvider.removeListener(_animeListListener);
    super.dispose();
  }

  Future<Map<String, dynamic>> getFilter() async {
    if (widget.animeListRandomObj.isEmpty) {
      _filter = {};
      return {};
    }
    _animeList = await _animeListProvider
        .get(filter: {"ListId": "${widget.animeListRandomObj.first.listId}"});

    List<int> animeIds =
        _animeList.result.map((animeList) => animeList.animeId!).toList();

    if (_animeList.result.isNotEmpty) {
      _filter = {
        "GenresIncluded": "true",
        "NewestFirst": "true",
        "Ids": animeIds,
      };
      return _filter;
    }
    _filter = {};
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      selectedIndex: widget.selectedIndex,
      showNavBar: true,
      showProfileIcon: false,
      showBackArrow: true,
      titleWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${widget.star.name}"),
          const SizedBox(width: 5),
          buildStarTrailIcon(24),
        ],
      ),
      child: FutureBuilder<Map<String, dynamic>>(
        future: _filterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Center(
                child: Wrap(
                  children: [
                    Text("Loading"),
                  ],
                ),
              ),
            ); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            Map<String, dynamic> filter = snapshot.data!;
            if (widget.animeListRandomObj.isEmpty || filter.isEmpty) {
              return const Empty(
                  text: Text("This Star is empty."),
                  screen: HomeScreen(selectedIndex: 0),
                  child: Text("Explore Anime"));
            }
            return AnimeCards(
              selectedIndex: widget.selectedIndex,
              page: page,
              pageSize: pageSize,
              fetchAnime: fetchAnime,
              fetchPage: fetchPage,
              filter: filter,
            );
          }
        },
      ),
    );
  }

  Future<SearchResult<Anime>> fetchAnime() {
    return _animeProvider.get(filter: {
      ..._filter,
      "Page": "$page",
      "PageSize": "$pageSize",
    });
  }

  Future<SearchResult<Anime>> fetchPage(Map<String, dynamic> filter) {
    return _animeProvider.get(filter: filter);
  }
}
