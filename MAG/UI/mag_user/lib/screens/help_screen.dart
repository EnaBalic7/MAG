import 'package:flutter/material.dart';
import 'package:mag_user/screens/asked_by_others_screen.dart';
import 'package:mag_user/screens/my_questions_screen.dart';

import '../widgets/master_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
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
      title: "Help",
      showBackArrow: true,
      showNavBar: false,
      tabs: const [
        Text(
          "My Questions",
        ),
        Text(
          "Asked by Others",
        )
      ],
      tabController: _tabController,
      labelPadding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 8,
        bottom: 5,
      ),
      showTabBar: true,
      child: TabBarView(controller: _tabController, children: [
        MyQuestionsScreen(),
        AskedByOthersScreen(),
      ]),
    );
  }
}
