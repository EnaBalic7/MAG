import 'package:flutter/material.dart';
import 'package:mag_user/widgets/anime_card.dart';
import 'package:provider/provider.dart';

import '../providers/rating_provider.dart';
import '../widgets/anime_indicator.dart';
import '../providers/anime_list_provider.dart';
import '../models/anime.dart';
import '../models/search_result.dart';
import '../utils/util.dart';
import '../widgets/pagination_buttons.dart';

typedef FetchPage = Future<SearchResult<Anime>> Function(
    Map<String, dynamic> filter);

// ignore: must_be_immutable
class AnimeCards extends StatefulWidget {
  final int selectedIndex;
  final Future<SearchResult<Anime>> Function() fetchAnime;
  final Future<Map<String, dynamic>> Function()? getFilter;
  final FetchPage fetchPage;
  Map<String, dynamic> filter;
  int page;
  int pageSize;

  AnimeCards({
    super.key,
    required this.selectedIndex,
    required this.fetchAnime,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
    this.getFilter,
  });

  @override
  State<AnimeCards> createState() => _AnimeCardsState();
}

class _AnimeCardsState extends State<AnimeCards>
    with AutomaticKeepAliveClientMixin<AnimeCards> {
  late Future<SearchResult<Anime>> _animeFuture;
  final ScrollController _scrollController = ScrollController();
  late final AnimeListProvider _animeListProvider;
  late final RatingProvider _ratingProvider;

  int totalItems = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(AnimeCards oldWidget) {
    // Check if filter has changed
    if (widget.filter != oldWidget.filter) {
      _animeFuture = widget.fetchAnime();
      setTotalItems();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _animeFuture = widget.fetchAnime();
    _animeListProvider = context.read<AnimeListProvider>();
    _ratingProvider = context.read<RatingProvider>();

    setTotalItems();

    _animeListProvider.addListener(() {
      setTotalItems();
    });

    _ratingProvider.addListener(_listener);

    super.initState();
  }

  @override
  void dispose() {
    _ratingProvider.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (mounted) {
      setState(() {
        _animeFuture = widget.fetchAnime();
      });
    }
  }

  void setTotalItems() async {
    var animeResult = await _animeFuture;
    if (mounted) {
      setState(() {
        totalItems = animeResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<SearchResult<Anime>>(
        future: _animeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Center(
                child: Wrap(
                  children: List.generate(6, (_) => const AnimeIndicator()),
                ),
              ),
            );
            // Loading state
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
                      page: widget.page,
                      pageSize: widget.pageSize,
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

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await widget.fetchPage({
        ...widget.filter,
        "Page": "$requestedPage",
        "PageSize": "${widget.pageSize}",
      });

      if (mounted) {
        setState(() {
          _animeFuture = Future.value(result);
          widget.page = requestedPage;
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
      (index) => AnimeCard(
          anime: animeList[index], selectedIndex: widget.selectedIndex),
    );
  }
}
