import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/search_result.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_cards.dart';

class LatestScreen extends StatefulWidget {
  final int selectedIndex;
  const LatestScreen({super.key, required this.selectedIndex});

  @override
  State<LatestScreen> createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  late AnimeProvider _animeProvider;
  int page = 0;
  int pageSize = 10;

  final Map<String, dynamic> _filter = {
    "GenresIncluded": "true",
    "NewestFirst": "true",
  };

  @override
  void initState() {
    _animeProvider = context.read<AnimeProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimeCards(
      selectedIndex: widget.selectedIndex,
      page: page,
      pageSize: pageSize,
      fetchAnime: fetchAnime,
      fetchPage: fetchPage,
      filter: _filter,
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
