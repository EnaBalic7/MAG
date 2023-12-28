import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mag_admin/screens/club_detail_screen.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:mag_admin/widgets/pagination_buttons.dart';
import 'package:provider/provider.dart';

import '../models/club.dart';
import '../models/search_result.dart';
import '../providers/club_provider.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';

class ClubsScreen extends StatefulWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  late ClubProvider _clubProvider;
  late Future<SearchResult<Club>> _clubFuture;
  TextEditingController _clubController = TextEditingController();

  int page = 0;
  int pageSize = 8;
  int totalItems = 0;
  bool isSearching = false;

  @override
  void initState() {
    _clubProvider = context.read<ClubProvider>();
    _clubFuture = _clubProvider.get(filter: {
      "CoverIncluded": "true",
      "Page": "$page",
      "PageSize": "$pageSize"
    });

    setTotalItems();

    super.initState();
  }

  void setTotalItems() async {
    var clubResult = await _clubFuture;
    setState(() {
      totalItems = clubResult.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Row(
        children: [
          buildClubsIcon(22),
          SizedBox(width: 5),
          Text("Clubs"),
        ],
      ),
      showSearch: true,
      onSubmitted: _search,
      controller: _clubController,
      child: FutureBuilder<SearchResult<Club>>(
        future: _clubFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var clubList = snapshot.data!.result;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildClubCards(clubList),
                    ),
                    MyPaginationButtons(
                        page: page,
                        pageSize: pageSize,
                        totalItems: totalItems,
                        fetchPage: fetchPage),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await _clubProvider.get(
        filter: {
          "Name": isSearching ? _clubController.text : null,
          "CoverIncluded": "true",
          "Page": "$requestedPage",
          "PageSize": "$pageSize",
        },
      );

      setState(() {
        _clubFuture = Future.value(result);
        page = requestedPage;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  void _search(String searchText) async {
    try {
      var result = await _clubProvider.get(filter: {
        "Name": searchText,
        "CoverIncluded": "true",
        "Page": "0",
        "PageSize": "$pageSize",
      });

      setState(() {
        _clubFuture = Future.value(result);
        isSearching = true;
        totalItems = result.count;
        page = 0;
      });
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
    return Container(
        width: 300,
        height: 453,
        margin: EdgeInsets.only(top: 20, left: 20, right: 0, bottom: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
        child: Column(
          children: [
            (club.cover != null)
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.memory(
                      imageFromBase64String(club.cover!.cover!),
                      width: 300,
                      height: 250,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 13),
                  child: Row(
                    children: [
                      buildUsersIcon(17),
                      SizedBox(width: 3),
                      Text("${club.memberCount}",
                          style: TextStyle(
                              color: Palette.lightPurple, fontSize: 13)),
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
                        club.name!,
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
                  child: _buildPopupMenu(club),
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
                      Text(club.description!),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildPopupMenu(Club club) {
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
            subtitle: Text('See more information about this club',
                style: TextStyle(color: Palette.lightPurple.withOpacity(0.5))),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ClubDetailScreen(club: club)));
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
                  Text("Are you sure you want to delete this club?"), () async {
                await _clubProvider.delete(club.id!);
              });
            },
          ),
        ),
      ],
    );
  }
}
