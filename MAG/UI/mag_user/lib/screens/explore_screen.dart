import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';

class ExploreScreen extends StatefulWidget {
  final int selectedIndex;
  const ExploreScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: true,
        title: "Explore",
        child: const Text("Explore"));
  }
}
