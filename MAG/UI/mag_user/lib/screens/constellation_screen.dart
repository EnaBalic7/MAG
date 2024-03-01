import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';

class ConstellationScreen extends StatefulWidget {
  final int selectedIndex;
  const ConstellationScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<ConstellationScreen> createState() => _ConstellationScreenState();
}

class _ConstellationScreenState extends State<ConstellationScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: true,
        title: "Constellation",
        child: const Text("Constellation"));
  }
}
