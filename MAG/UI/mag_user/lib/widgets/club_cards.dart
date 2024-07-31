import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/club_cover_provider.dart';
import '../providers/club_provider.dart';
import '../widgets/empty.dart';
import '../providers/club_user_provider.dart';
import '../screens/club_detail_screen.dart';
import '../utils/icons.dart';
import '../widgets/pagination_buttons.dart';
import '../models/club.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import 'club_form.dart';

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
  bool? showPagination;
  bool? showPopupMenuButton;

  /// Shows Empty widget in case there are no clubs
  bool? showEmpty;

  ClubCards({
    Key? key,
    required this.selectedIndex,
    required this.fetchClubs,
    this.getFilter,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
    this.showPagination = true,
    this.showPopupMenuButton = false,
    this.showEmpty = true,
  }) : super(key: key);

  @override
  State<ClubCards> createState() => _ClubCardsState();
}

class _ClubCardsState extends State<ClubCards> {
  late Future<SearchResult<Club>> _clubFuture;
  final ScrollController _scrollController = ScrollController();
  late final ClubProvider _clubProvider;
  int totalItems = 0;
  late final ClubUserProvider _clubUserProvider;
  late final ClubCoverProvider _clubCoverProvider;

  @override
  void didUpdateWidget(ClubCards oldWidget) {
    // Results will show only in the second instance of ClubCards in ClubsScreen
    if (widget.showPagination == true) {
      // Check if filter has changed
      if (widget.filter != oldWidget.filter) {
        _clubFuture = widget.fetchClubs();
        setTotalItems();
      }
      super.didUpdateWidget(oldWidget);
    }
  }

  @override
  void initState() {
    _clubFuture = widget.fetchClubs();
    setTotalItems();
    _clubProvider = context.read<ClubProvider>();
    _clubUserProvider = context.read<ClubUserProvider>();
    _clubCoverProvider = context.read<ClubCoverProvider>();

    _clubProvider.addListener(() {
      _reloadData();
    });

    _clubCoverProvider.addListener(() {
      _reloadData();
    });

    _clubUserProvider.addListener(() {
      _reloadData();
    });

    super.initState();
  }

  void _reloadData() {
    if (mounted) {
      if (widget.showPagination == true) {
        setState(() {
          _clubFuture = _clubProvider.get(filter: {
            ...widget.filter,
            "Page": "${widget.page}",
            "PageSize": "${widget.pageSize}"
          });
        });
      } else if (widget.showPagination == false) {
        setState(() {
          _clubFuture = _clubProvider.get(filter: {
            ...widget.filter,
          });
        });
      }
    }
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
            if (widget.showPagination == false) {
              return Center(child: _buildClubCardIndicator());
            }
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

            if (clubList.isEmpty && widget.showEmpty == true) {
              return const Empty(
                  showGradientButton: false, text: Text("No clubs here~"));
            }

            return SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildClubCards(clubList),
                    ),
                    Visibility(
                      visible: widget.showPagination!,
                      child: MyPaginationButtons(
                        page: widget.page,
                        pageSize: widget.pageSize,
                        totalItems: totalItems,
                        fetchPage: fetchPage,
                        hasSearch: false,
                      ),
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

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ClubDetailScreen(
            club: club,
            selectedIndex: widget.selectedIndex,
          ),
        ));
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: const EdgeInsets.only(
          left: 7,
          right: 7,
          top: 5,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
          color: Palette.darkPurple,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (club.cover != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.memory(
                            imageFromBase64String(club.cover!.cover!),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Palette.lightPurple.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.image,
                            color: Palette.lightPurple.withOpacity(0.4),
                            size: 36,
                          ),
                        ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (widget.showPopupMenuButton == true)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${club.name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              _buildPopupMenu(club),
                            ],
                          )
                        : SizedBox(
                            width: cardWidth * 0.62,
                            child: Text("${club.name}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                    SizedBox(
                      width: cardWidth * 0.62,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClubCardIndicator() {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width;
    double? cardHeight = 130;

    return Padding(
      padding: const EdgeInsets.all(7),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
          color: Palette.buttonPurple.withOpacity(0.1),
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
                  ).asGlass(
                    tintColor: Palette.lightPurple,
                    clipBorderRadius: BorderRadius.circular(100),
                    blurX: 3,
                    blurY: 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Palette.lightPurple,
                    highlightColor: Palette.white,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: cardWidth * 0.6),
                      child: const SizedBox(
                        width: 150,
                        height: 13,
                      ).asGlass(),
                    ).asGlass(
                        clipBorderRadius: BorderRadius.circular(4),
                        tintColor: Palette.lightPurple),
                  ),
                  ...List.generate(
                    4,
                    (index) => Shimmer.fromColors(
                      baseColor: Palette.lightPurple,
                      highlightColor: Palette.white,
                      child: SizedBox(
                        width: cardWidth * 0.6,
                        height: 9,
                      ).asGlass(
                        clipBorderRadius: BorderRadius.circular(3),
                        tintColor: Palette.lightPurple,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Palette.lightPurple.withOpacity(0.5),
                        highlightColor: Palette.white.withOpacity(0.5),
                        child: buildUsersIcon(18),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).asGlass(
        blurX: 0,
        blurY: 0,
        tintColor: Palette.lightPurple,
        clipBorderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _buildPopupMenu(Club club) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Palette.darkPurple.withOpacity(0.8),
      ),
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
              title: const Text('Edit',
                  style: TextStyle(color: Palette.lightPurple)),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ClubForm(club: club);
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
                      "Are you sure you want to delete this club?",
                      textAlign: TextAlign.center,
                    ), () async {
                  try {
                    await _clubProvider.delete(club.id!);
                  } on Exception catch (e) {
                    showErrorDialog(context, e);
                  }
                });
              },
            ),
          ),
        ],
      ),
    ).asGlass(
      blurX: 1,
      blurY: 1,
      clipBorderRadius: BorderRadius.circular(20),
      tintColor: Palette.darkPurple,
    );
  }
}
