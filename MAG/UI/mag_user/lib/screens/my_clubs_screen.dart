import 'package:flutter/material.dart';
import 'package:mag_user/screens/joined_clubs_screen.dart';
import 'package:mag_user/screens/owned_clubs_screen.dart';
import 'package:mag_user/widgets/master_screen.dart';

class MyClubsScreen extends StatefulWidget {
  final int selectedIndex;
  const MyClubsScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<MyClubsScreen> createState() => _MyClubsScreenState();
}

class _MyClubsScreenState extends State<MyClubsScreen>
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
      title: "My Clubs",
      showBackArrow: true,
      showTabBar: true,
      tabController: _tabController,
      tabs: const [
        Text(
          "Owned",
        ),
        Text(
          "Joined",
        ),
      ],
      labelPadding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 8,
        bottom: 5,
      ),
      child: TabBarView(controller: _tabController, children: [
        OwnedClubsScreen(selectedIndex: widget.selectedIndex),
        JoinedClubsScreen(selectedIndex: widget.selectedIndex),
      ]),
    );
  }
}
