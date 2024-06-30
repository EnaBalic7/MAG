import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/club.dart';
import '../models/search_result.dart';
import '../providers/club_provider.dart';
import '../utils/util.dart';
import '../widgets/club_cards.dart';

class JoinedClubsScreen extends StatefulWidget {
  final int selectedIndex;
  const JoinedClubsScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<JoinedClubsScreen> createState() => _JoinedClubsScreenState();
}

class _JoinedClubsScreenState extends State<JoinedClubsScreen> {
  late ClubProvider _clubProvider;

  int page = 0;
  int pageSize = 10;

  final Map<String, dynamic> _filter = {
    "CoverIncluded": "true",
    "OrderByMemberCount": "true",
    "UserId": "${LoggedUser.user!.id}",
    "GetJoinedClubs": "true",
  };

  @override
  void initState() {
    _clubProvider = context.read<ClubProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClubCards(
      selectedIndex: widget.selectedIndex,
      page: page,
      pageSize: pageSize,
      fetchClubs: fetchClubs,
      fetchPage: fetchPage,
      filter: _filter,
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
