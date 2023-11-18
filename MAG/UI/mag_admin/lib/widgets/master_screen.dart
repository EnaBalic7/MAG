// ignore_for_file: prefer_const_constructors

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mag_admin/screens/anime_screen.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import './/main.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
  TextEditingController? controller;
  void Function(String)? onSubmitted;
  bool? showBackArrow;
  bool? showSearch;
  MasterScreenWidget({
    Key? key,
    this.child,
    this.title,
    this.title_widget,
    this.controller,
    this.onSubmitted,
    this.showBackArrow,
    this.showSearch,
  }) : super(key: key);

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
      appBar: AppBarWithSearchSwitch(
        closeOnSubmit: false,
        onSubmitted: widget.onSubmitted,
        customTextEditingController: widget.controller,
        titleTextStyle: TextStyle(fontSize: 16),
        centerTitle: true,
        searchInputDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 5, left: 15),
            hintText: "Search",
            hintStyle: TextStyle(color: Palette.lightPurple, fontSize: 16),
            fillColor: Palette.searchBar,
            constraints: BoxConstraints(maxHeight: 40, maxWidth: 500),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
        iconTheme: IconThemeData(color: Palette.lightPurple),
        appBarBuilder: (context) {
          return AppBar(
              leading: _buildLeading(context),
              title: widget.title_widget ?? Text(widget.title ?? ""),
              actions: _buildActions,
              iconTheme: IconThemeData(color: Palette.lightPurple));
        },
      ),
      drawer: Drawer(
          child: ListView(children: [
        Container(child: Image.asset('assets/images/logo.png')),
        buildListTile(context, 'Login',
            Icon(Icons.login, color: Palette.lightPurple), LoginPage()),
        buildListTile(context, 'Anime', buildAnimeIcon(), AnimeScreen()),
        buildListTile(context, 'Users', buildUsersIcon(), LoginPage()),
        buildListTile(context, 'Analytics', buildAnalyticsIcon(), LoginPage()),
        buildListTile(context, 'Clubs', buildClubsIcon(), LoginPage()),
        buildListTile(context, 'Help', buildHelpIcon(), LoginPage())
      ])),
      body: Stack(children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset('assets/images/starsBg.png', fit: BoxFit.cover),
          ),
        ),
        widget.child!
      ]),
    );
  }

  List<Widget> get _buildActions {
    List<Widget> actions = [];
    if (widget.showSearch == true) {
      actions.add(AppBarSearchButton(
        searchIcon: buildSearchIcon(true),
        searchActiveButtonColor: Palette.lightRed,
        searchActiveIcon: buildSearchIcon(true),
      ));
    }
    actions.add(SizedBox(width: 10));
    actions.add(buildAstronautIcon());
    actions.add(SizedBox(width: 40));
    return actions;
  }

  Widget _buildLeading(BuildContext context) {
    if (widget.showBackArrow == true) {
      return InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Palette.lightPurple,
          ));
    } else {
      return Builder(
          builder: (context) => IconButton(
                icon: new Icon(Icons.menu_rounded),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ));
    }
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
            gradient:
                (hoverStates[title] == true) ? Palette.menuGradient : null,
            borderRadius: BorderRadius.circular(50)),
        child: ListTile(
          title: Text(title, style: TextStyle(fontSize: 16)),
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
