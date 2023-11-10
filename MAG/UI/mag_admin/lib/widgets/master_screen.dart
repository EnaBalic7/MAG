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
  bool? isHover;
  Map<String, bool> hoverStates = {
    'Login': false,
    'Anime': false,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: widget.title_widget ?? Text(widget.title ?? ""),
            iconTheme: IconThemeData(color: Palette.lightPurple)),
        drawer: Drawer(
            child: ListView(children: [
          Container(child: Image.asset('assets/images/logo.png')),
          buildListTile(context, 'Login', Icon(Icons.login), LoginPage()),
          buildListTile(
              context,
              'Anime',
              Image.asset(
                '/assets/icons/AnimeIco.png',
                width: 48,
                height: 48,
              ),
              LoginPage()),
        ])),
        body: Stack(children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child:
                  Image.asset('assets/images/starsBg.png', fit: BoxFit.cover),
            ),
          ),
          widget.child!
        ]));
  }

  MouseRegion buildListTile(
      BuildContext context, String title, Widget leading, Widget screen) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        hoverStates[title] = true;
      }),
      onExit: (event) => setState(() {
        hoverStates[title] = false;
      }),
      child: Container(
        decoration: BoxDecoration(
            gradient: (hoverStates[title] == true) ? Palette.gradient : null,
            borderRadius: BorderRadius.circular(50)),
        child: ListTile(
          title: Text(title),
          leading: leading,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => screen,
              ),
            );
          },
        ),
      ),
    );
  }
}
