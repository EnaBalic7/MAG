import 'package:flutter/material.dart';
import 'package:mag_user/screens/my_clubs_screen.dart';
import 'package:provider/provider.dart';

import '../providers/club_provider.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/club_cards.dart';
import '../widgets/club_form.dart';
import '../widgets/gradient_button.dart';
import '../widgets/separator.dart';
import '../models/club.dart';
import '../models/search_result.dart';
import '../widgets/master_screen.dart';

class ClubsScreen extends StatefulWidget {
  final int selectedIndex;
  const ClubsScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  late ClubProvider _clubProvider;
  final TextEditingController _searchController = TextEditingController();

  int page = 0;
  int pageSize = 10;

  Map<String, dynamic> _filter = {
    "CoverIncluded": "true",
    "OrderByMemberCount": "true",
  };

  @override
  void initState() {
    _clubProvider = context.read<ClubProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double separatorWidth = screenSize.width * 0.9;

    return MasterScreenWidget(
      selectedIndex: widget.selectedIndex,
      showNavBar: true,
      showSearch: true,
      showHelpIcon: true,
      controller: _searchController,
      onSubmitted: _search,
      title: "Clubs",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTop(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MySeparator(
                width: separatorWidth,
                borderRadius: 50,
                opacity: 0.5,
                paddingTop: 5,
                paddingBottom: 5,
              ),
            ],
          ),
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: Text("My Clubs"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: GradientButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyClubsScreen(
                            selectedIndex: widget.selectedIndex,
                          ),
                        ),
                      );
                    },
                    width: 60,
                    height: 20,
                    gradient: Palette.buttonGradient2,
                    borderRadius: 50,
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Palette.lightPurple),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Create a club"),
                GradientButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return ClubForm();
                        });
                  },
                  width: 30,
                  height: 30,
                  gradient: Palette.buttonGradient2,
                  borderRadius: 50,
                  child:
                      const Icon(Icons.add_rounded, color: Palette.lightPurple),
                ),
              ],
            )
          ],
        ),
        ClubCards(
          selectedIndex: widget.selectedIndex,
          page: page,
          pageSize: pageSize,
          fetchClubs: fetchOneClub,
          fetchPage: fetchPage,
          filter: _filter,
          showPagination: false,
        ),
      ],
    );
  }

  Expanded _buildBottom() {
    return Expanded(
      child: ClubCards(
        selectedIndex: widget.selectedIndex,
        page: page,
        pageSize: pageSize,
        fetchClubs: fetchClubs,
        fetchPage: fetchPage,
        filter: _filter,
      ),
    );
  }

  void _search(String text) {
    setState(() {
      _filter = {
        "Name": _searchController.text,
        "CoverIncluded": "true",
        "OrderByMemberCount": "true",
      };
    });
  }

  Future<SearchResult<Club>> fetchOneClub() {
    return _clubProvider.get(filter: {
      "OwnerId": "${LoggedUser.user!.id}",
      "CoverIncluded": "true",
      "Page": "0",
      "PageSize": "1",
    });
  }

  Future<SearchResult<Club>> fetchClubs() {
    return _clubProvider.get(filter: {
      ..._filter,
      "Page": "$page",
      "PageSize": "$pageSize",
    });
  }

  Future<SearchResult<Club>> fetchPage(Map<String, dynamic> filter) {
    return _clubProvider.get(filter: filter);
  }
}
