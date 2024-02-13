import 'package:flutter/material.dart';
import 'package:mag_user/widgets/master_screen.dart';

import '../utils/colors.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
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
      child: const Text("Test"),
    );
  }
}
