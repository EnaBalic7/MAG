import 'package:flutter/material.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';

import '../utils/colors.dart';
import '../widgets/line_chart.dart';

class TestingGround extends StatefulWidget {
  const TestingGround({Key? key}) : super(key: key);

  @override
  State<TestingGround> createState() => _TestingGroundState();
}

class _TestingGroundState extends State<TestingGround> {
  var changingImg = Image.asset("assets/images/cauldron.png", height: 600);
  bool changed = false;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<MyLineChartState> chartKey = GlobalKey();
  //final ScrollController _scrollController =
  // ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        //key: _scaffoldKey,
        showFloatingActionButton: true,
        floatingActionButtonIcon:
            const Icon(Icons.spa_rounded, size: 40, color: Palette.lightPurple),
        floatingButtonOnPressed: () {
          setState(() {
            if (changed == false) {
              changingImg = Image.asset("assets/images/moon.png", height: 600);
              changed = true;
            } else {
              changingImg =
                  Image.asset("assets/images/cauldron.png", height: 600);
              changed = false;
            }
          });
          //chartKey.currentState?.methodInChild();
        },
        titleWidget: const Text("Testing"),
        child: Center(
          child: SingleChildScrollView(
            //controller: _scrollController,
            //key: _scrollKey,
            child: Column(
              children: [
                Image.asset("assets/images/cauldron.png", height: 600),
                MyLineChart(key: chartKey),
                // Image.asset("assets/images/animeWitch.png"),
                GradientButton(
                    onPressed: () {
                      chartKey.currentState?.methodInChild();
                    },
                    width: 100,
                    height: 30,
                    gradient: Palette.buttonGradient,
                    borderRadius: 50,
                    child: const Text("Filter"))
              ],
            ),
          ),
        ));
  }
}
