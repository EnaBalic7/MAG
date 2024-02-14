import 'package:flutter/material.dart';
import 'package:mag_user/widgets/master_screen.dart';

class NebulaScreen extends StatefulWidget {
  final int selectedIndex;
  NebulaScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<NebulaScreen> createState() => _NebulaScreenState();
}

class _NebulaScreenState extends State<NebulaScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: true,
        title: "Nebula",
        child: const Text("Nebula"));
  }
}
