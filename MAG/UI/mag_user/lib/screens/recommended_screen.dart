import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/search_result.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_cards.dart';

class RecommendedScreen extends StatefulWidget {
  final int selectedIndex;
  const RecommendedScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<RecommendedScreen> createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {
  late AnimeProvider _animeProvider;
  int page = 0;
  int pageSize = 8;

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
      filter: const {
        "GenresIncluded": "true",
        "NewestFirst": "true",
      },
    );
  }

  Future<SearchResult<Anime>> fetchAnime() {
    return _animeProvider.get(filter: {
      "GenresIncluded": "true",
      "NewestFirst": "true",
      "Page": "$page",
      "PageSize": "$pageSize",
    });
  }

  Future<SearchResult<Anime>> fetchPage(Map<String, dynamic> filter) {
    return _animeProvider.get(filter: filter);
  }
}
