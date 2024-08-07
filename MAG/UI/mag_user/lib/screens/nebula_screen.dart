import 'package:flutter/material.dart';

import '../screens/nebula_all_screen.dart';
import '../screens/nebula_completed_screen.dart';
import '../screens/nebula_dropped_screen.dart';
import '../screens/nebula_onHold_screen.dart';
import '../screens/nebula_planToWatch_screen.dart';
import '../screens/nebula_watching_screen.dart';
import '../widgets/master_screen.dart';

class NebulaScreen extends StatefulWidget {
  final int selectedIndex;
  const NebulaScreen({super.key, required this.selectedIndex});

  @override
  State<NebulaScreen> createState() => _NebulaScreenState();
}

class _NebulaScreenState extends State<NebulaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Nebula",
      selectedIndex: widget.selectedIndex,
      showNavBar: true,
      showTabBar: true,
      showHelpIcon: true,
      tabController: _tabController,
      isScrollable: true,
      tabs: const [
        Text(
          "All",
        ),
        Text(
          "Watching",
        ),
        Text(
          "Completed",
        ),
        Text(
          "On Hold",
        ),
        Text(
          "Dropped",
        ),
        Text(
          "Plan to Watch",
        ),
      ],
      labelPadding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 8,
        bottom: 5,
      ),
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: TabBarView(controller: _tabController, children: [
        NebulaAllScreen(selectedIndex: widget.selectedIndex),
        NebulaWatchingScreen(selectedIndex: widget.selectedIndex),
        NebulaCompletedScreen(selectedIndex: widget.selectedIndex),
        NebulaOnHoldScreen(selectedIndex: widget.selectedIndex),
        NebulaDroppedScreen(selectedIndex: widget.selectedIndex),
        NebulaPlanToWatchScreen(selectedIndex: widget.selectedIndex),
      ]),
    );
  }
}
