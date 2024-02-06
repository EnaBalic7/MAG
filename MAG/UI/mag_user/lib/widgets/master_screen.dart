import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import 'gradient_button.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? titleWidget;
  TextEditingController? controller;
  void Function(String)? onSubmitted;
  void Function()? onClosed;
  void Function(String)? onChanged;
  void Function()? onCleared;
  void Function()? floatingButtonOnPressed;
  bool? showBackArrow;
  bool? showSearch;
  bool? showFloatingActionButton;
  Widget? floatingActionButtonIcon;
  GradientButton? gradientButton;
  bool? showProfileIcon;
  String? floatingButtonTooltip;
  MasterScreenWidget({
    Key? key,
    required this.child,
    this.title,
    this.titleWidget,
    this.controller,
    this.onSubmitted,
    this.onClosed,
    this.onChanged,
    this.onCleared,
    this.showBackArrow,
    this.showSearch,
    this.showFloatingActionButton = false,
    this.floatingActionButtonIcon,
    this.gradientButton,
    this.floatingButtonOnPressed,
    this.showProfileIcon = true,
    this.floatingButtonTooltip,
  }) : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  bool? removeAppBar;
  late UserProvider _userProvider;
  Map<String, bool> hoverStates = {
    'Login': false,
    'Anime': false,
    'Users': false,
    'Analytics': false,
    'Clubs': false,
    'Help': false
  };

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      appBar: AppBarWithSearchSwitch(
        //closeOnSubmit: false,
        onSubmitted: widget.onSubmitted,
        onClosed: widget.onClosed,
        onChanged: widget.onChanged,
        onCleared: widget.onCleared,
        customTextEditingController: widget.controller,
        titleTextStyle: const TextStyle(fontSize: 16),
        centerTitle: true,
        searchInputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5, left: 15),
            hintText: "Search",
            hintStyle:
                const TextStyle(color: Palette.lightPurple, fontSize: 16),
            fillColor: Palette.searchBar,
            constraints: const BoxConstraints(maxHeight: 40, maxWidth: 500),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
        iconTheme: const IconThemeData(color: Palette.lightPurple),
        appBarBuilder: (context) {
          return AppBar(
              leading: _buildLeading(context),
              title: widget.titleWidget ?? Text(widget.title ?? ""),
              actions: _buildActions,
              iconTheme: const IconThemeData(color: Palette.lightPurple));
        },
      ),
      drawer: Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Image.asset('assets/images/logo.png', width: 220),
                ),
                /* buildListTile(
                    context, 'Anime', buildAnimeIcon(24), const AnimeScreen()),
                buildListTile(
                    context, 'Users', buildUsersIcon(24), const UsersScreen()),
                buildListTile(
                    context, 'Reports', buildReportsIcon(24), ReportsScreen()),
                buildListTile(
                    context, 'Clubs', buildClubsIcon(24), const ClubsScreen()),
                buildListTile(
                    context, 'Help', buildHelpIcon(24), const HelpScreen()),*/
                /*buildListTile(
                    context,
                    'Testing',
                    const Icon(Icons.star_rounded, color: Palette.lightPurple),
                    const TestingGround()),*/
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: buildListTile(
                  context,
                  'Log out',
                  const Icon(
                    Icons.logout_rounded,
                    color: Palette.lightPurple,
                  ),
                  LoginScreen()),
            )
          ])),
      body: Stack(children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset('assets/images/starsBg.png', fit: BoxFit.cover),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: widget.child!,
        )
      ]),
    );
  }

  Widget _buildFloatingActionButton() {
    if (widget.showFloatingActionButton == false) {
      return Container();
    }

    return Tooltip(
      message: widget.floatingButtonTooltip ?? "",
      verticalOffset: 50,
      child: GradientButton(
          width: 90,
          height: 90,
          borderRadius: 100,
          onPressed: widget.floatingButtonOnPressed,
          gradient: Palette.menuGradient,
          child: widget.floatingActionButtonIcon ??
              const Icon(Icons.add_rounded,
                  size: 48, color: Palette.lightPurple)),
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
    actions.add(const SizedBox(width: 10));
    if (widget.showProfileIcon == true) {
      actions.add(GestureDetector(
          onTap: () async {
            var userTmp = await _userProvider.get(filter: {
              "Username": "${Authorization.username}",
              "ProfilePictureIncluded": "true"
            });
            if (userTmp.count == 1) {
              User user = userTmp.result.first;

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: user),
                ),
              );
            }
          },
          child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Tooltip(
                  message: "View profile", child: buildAstronautIcon()))));
    }

    actions.add(const SizedBox(width: 40));
    return actions;
  }

  Widget _buildLeading(BuildContext context) {
    if (widget.showBackArrow == true) {
      return InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Palette.lightPurple,
          ));
    } else {
      return Builder(
          builder: (context) => IconButton(
                icon: const Icon(Icons.menu_rounded),
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
          title: Text(title, style: const TextStyle(fontSize: 16)),
          leading: leading,
          onTap: () {
            if (title == 'Log out') {
              Authorization.username = "";
              Authorization.password = "";
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => screen,
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => screen,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
