import 'package:flutter/material.dart';
import 'package:mag_user/screens/recommended_screen.dart';
import 'package:mag_user/screens/top_anime_screen.dart';
import 'package:mag_user/widgets/master_screen.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  const HomeScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      selectedIndex: widget.selectedIndex,
      showTabBar: true,
      tabController: _tabController,
      title: "Home",
      tabs: const [
        Text(
          "Top Anime",
        ),
        Text(
          "Recommended",
        )
      ],
      child: TabBarView(controller: _tabController, children: [
        TopAnimeScreen(selectedIndex: widget.selectedIndex),
        RecommendedScreen(selectedIndex: widget.selectedIndex),
      ]),
    );
  }
}
