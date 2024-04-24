import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/search_result.dart';
import '../widgets/master_screen.dart';
import '../providers/list_provider.dart';

class ConstellationScreen extends StatefulWidget {
  final int selectedIndex;
  const ConstellationScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<ConstellationScreen> createState() => _ConstellationScreenState();
}

class _ConstellationScreenState extends State<ConstellationScreen> {
  late ListProvider _listProvider;

  int page = 0;
  int pageSize = 20;

  final Map<String, dynamic> _filter = {
    "NewestFirst": "true",
  };

  @override
  void initState() {
    _listProvider = context.read<ListProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: true,
        title: "Constellation",
        showFloatingActionButton: true,
        child: const Text("Constellation"));
  }

  /* Future<SearchResult<List>> fetchConstellations() {
    return _listProvider.get(filter: {
      ..._filter,
      "Page": "$page",
      "PageSize": "$pageSize",
    });
  }*/
}
