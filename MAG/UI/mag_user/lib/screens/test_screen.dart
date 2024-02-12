import 'package:flutter/material.dart';
import 'package:mag_user/widgets/master_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(showSearch: true, child: const Text("Test"));
  }
}
