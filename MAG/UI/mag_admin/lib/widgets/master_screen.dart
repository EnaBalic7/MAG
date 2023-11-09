import 'package:flutter/material.dart';
import '../utils/colors.dart';
import './/main.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;

  MasterScreenWidget({this.child, this.title, this.title_widget, Key? key})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: widget.title_widget ?? Text(widget.title ?? ""),
            iconTheme: IconThemeData(color: Palette.lightPurple)),
        drawer: Drawer(
            child: ListView(children: [
          Container(
            decoration: BoxDecoration(
                gradient: Palette.gradient,
                borderRadius: BorderRadiusGeometry.lerp(null, null, 50)),
            child: ListTile(
              title: Text("Login"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ),
        ])),
        body: Stack(children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                  'assets/images/starsBg.png', // Replace with your image asset path
                  fit: BoxFit.cover),
            ),
          ),
          widget.child!
        ]));
  }
}
