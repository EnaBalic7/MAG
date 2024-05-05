import 'package:flutter/material.dart';
import 'package:mag_user/widgets/master_screen.dart';
import 'package:mag_user/widgets/numeric_step_button.dart';

import '../utils/colors.dart';

class TestingScreen extends StatefulWidget {
  final int selectedIndex;
  const TestingScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      selectedIndex: widget.selectedIndex,
      showNavBar: true,
      title: "Testing",
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CardWidget(),
              CardWidget(),
              CardWidget(),
              CardWidget(),
              CardWidget(),
              CardWidget(),
              CardWidget(),
              CardWidget(),
              CardWidget(),
              CardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.darkPurple,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Stateless Card Widget'),
            SizedBox(height: 20),
            CounterWidget(),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Counter: $_counter'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
