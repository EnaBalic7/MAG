import 'package:flutter/material.dart';
import 'package:mag_user/providers/club_provider.dart';
import 'package:mag_user/widgets/club_cards.dart';
import 'package:provider/provider.dart';

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

  int page = 0;
  int pageSize = 10;

  final Map<String, dynamic> _filter = {
    "CoverIncluded": "true",
  };

  @override
  void initState() {
    _clubProvider = context.read<ClubProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      selectedIndex: widget.selectedIndex,
      showNavBar: true,
      showHelpIcon: true,
      title: "Clubs",
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
