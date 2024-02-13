import 'package:flutter/material.dart';
import 'package:mag_user/widgets/master_screen.dart';

class NebulaScreen extends StatefulWidget {
  const NebulaScreen({Key? key}) : super(key: key);

  @override
  State<NebulaScreen> createState() => _NebulaScreenState();
}

class _NebulaScreenState extends State<NebulaScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        showNavBar: true, title: "Nebula", child: const Text("Nebula"));
  }
}
