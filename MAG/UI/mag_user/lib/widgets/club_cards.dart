import 'package:flutter/material.dart';
import 'package:mag_user/utils/icons.dart';
import 'package:mag_user/widgets/pagination_buttons.dart';

import '../models/club.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../utils/util.dart';

typedef FetchPage = Future<SearchResult<Club>> Function(
    Map<String, dynamic> filter);

class ClubCards extends StatefulWidget {
  final int selectedIndex;
  final Future<SearchResult<Club>> Function() fetchClubs;
  final Future<Map<String, dynamic>> Function()? getFilter;
  final FetchPage fetchPage;
  Map<String, dynamic> filter;
  int page;
  int pageSize;

  ClubCards({
    Key? key,
    required this.selectedIndex,
    required this.fetchClubs,
    this.getFilter,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
  }) : super(key: key);

  @override
  State<ClubCards> createState() => _ClubCardsState();
}

class _ClubCardsState extends State<ClubCards> {
  late Future<SearchResult<Club>> _clubFuture;
  final ScrollController _scrollController = ScrollController();
  int totalItems = 0;

  @override
  void initState() {
    _clubFuture = widget.fetchClubs();
    setTotalItems();

    super.initState();
  }

  void setTotalItems() async {
    var clubResult = await _clubFuture;
    if (mounted) {
      setState(() {
        totalItems = clubResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchResult<Club>>(
        future: _clubFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Center(
                child: Wrap(
                  children: List.generate(6, (_) => _buildClubCardIndicator()),
                ),
              ),
            );
            // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var clubList = snapshot.data!.result;
            return SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildClubCards(clubList),
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
          _clubFuture = Future.value(result);
          widget.page = requestedPage;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  List<Widget> _buildClubCards(List<Club> clubList) {
    return List.generate(
      clubList.length,
      (index) => _buildClubCard(clubList[index]),
    );
  }

  Widget _buildClubCard(Club club) {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width;
    double? cardHeight = 130;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
        color: Palette.darkPurple,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.memory(
                    imageFromBase64String(club.cover!.cover!),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: cardWidth - 140,
                  child: Text("${club.name}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  width: cardWidth - 140,
                  child: Text("${club.description}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                Row(
                  children: [
                    buildUsersIcon(18),
                    const SizedBox(width: 5),
                    Text("${club.memberCount}")
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClubCardIndicator() {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width;
    double? cardHeight = 130;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
        color: Palette.darkPurple,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: cardWidth - 150,
                  child: Text("",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  width: cardWidth - 150,
                  child: Text("",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                Row(
                  children: [
                    buildUsersIcon(18),
                    const SizedBox(width: 5),
                    Text("")
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
