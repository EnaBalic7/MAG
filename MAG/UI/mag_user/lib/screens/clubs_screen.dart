import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';

class ClubsScreen extends StatefulWidget {
  final int selectedIndex;
  const ClubsScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: true,
        title: "Clubs",
        child: const Text("Clubs"));
  }
}
