// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mag_admin/screens/anime_screen.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
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
  bool? removeAppBar;
  Map<String, bool> hoverStates = {
    'Login': false,
    'Anime': false,
    'Users': false,
    'Analytics': false,
    'Clubs': false,
    'Help': false
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: widget.title_widget ?? Text(widget.title ?? ""),
            actions: [buildAstronautIcon(), SizedBox(width: 40)],
            iconTheme: IconThemeData(color: Palette.lightPurple)),
        drawer: Drawer(
            child: ListView(children: [
          Container(child: Image.asset('assets/images/logo.png')),
          buildListTile(context, 'Login',
              Icon(Icons.login, color: Palette.lightPurple), LoginPage()),
          buildListTile(context, 'Anime', buildAnimeIcon(), AnimeScreen()),
          buildListTile(context, 'Users', buildUsersIcon(), LoginPage()),
          buildListTile(
              context, 'Analytics', buildAnalyticsIcon(), LoginPage()),
          buildListTile(context, 'Clubs', buildClubsIcon(), LoginPage()),
          buildListTile(context, 'Help', buildHelpIcon(), LoginPage())
        ])),
        body: Stack(children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
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
