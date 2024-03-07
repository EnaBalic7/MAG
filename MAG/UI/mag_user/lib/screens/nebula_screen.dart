import 'package:flutter/material.dart';
import 'package:mag_user/utils/icons.dart';
import 'package:mag_user/widgets/master_screen.dart';

import '../utils/colors.dart';

class NebulaScreen extends StatefulWidget {
  final int selectedIndex;
  NebulaScreen({Key? key, required this.selectedIndex}) : super(key: key);

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildNebulaCard(),
            _buildNebulaCard(),
            _buildNebulaCard(),
            _buildNebulaCard(),
            _buildNebulaCard(),
            _buildNebulaCard(),
            _buildNebulaCard(),
            _buildNebulaCard(),
            _buildNebulaCard(),
          ],
        ),
      ),
    );
  }

  /* TabBarView(controller: _tabController, children: [
        _buildNebulaCard(),
        Text("Watching"),
        Text("Completed"),
        Text("On Hold"),
        Text("Dropped"),
        Text("Plan to Watch"),
      ]),*/

  Widget _buildNebulaCard() {
    Size screenSize = MediaQuery.of(context).size;
    double containerWidth = screenSize.width;
    double containerHeight = screenSize.height * 0.15;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        //constraints: BoxConstraints(maxHeight: 200),
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(color: Palette.buttonPurple.withOpacity(0.4)),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              "https://i.pinimg.com/originals/b7/cb/e3/b7cbe39fa4bb2f60bd34db26c73b464e.jpg",
              fit: BoxFit.cover,
              // width: 100,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: containerWidth * 0.6),
                            child: const Text("Little Witch Academia",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                          ),
                          const Text("Winter 2017",
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      buildEditIcon(30),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          buildStarIcon(20),
                          const Text("10",
                              style: TextStyle(color: Palette.starYellow))
                        ],
                      ),
                      const Text("Progress: 24/24 ep",
                          style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
