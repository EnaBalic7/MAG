import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
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
  int _selectedIndex = 0;

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
      bottomNavigationBar: ResponsiveNavigationBar(
        backgroundColor: Palette.darkPurple,
        textStyle: const TextStyle(
          color: Palette.white,
          fontWeight: FontWeight.w500,
        ),
        outerPadding: const EdgeInsets.all(0),
        borderRadius: 0,
        borderRadiusItem: 50,
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        navigationBarButtons: const <NavigationBarButton>[
          NavigationBarButton(
            text: 'Home',
            icon: Icons.people,
            backgroundGradient: Palette.navGradient1,
          ),
          NavigationBarButton(
            text: 'My Nebula',
            icon: Icons.star,
            backgroundGradient: Palette.navGradient2,
          ),
          NavigationBarButton(
            text: 'Explore',
            icon: Icons.settings,
            backgroundGradient: Palette.navGradient3,
          ),
          NavigationBarButton(
            text: 'Constellation',
            icon: Icons.star,
            backgroundGradient: Palette.navGradient4,
          ),
          NavigationBarButton(
            text: 'Clubs',
            icon: Icons.settings,
            backgroundGradient: Palette.navGradient5,
          ),
        ],
      )

      /*BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Palette.darkPurple,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Palette.teal,
          unselectedItemColor: Palette.lightPurple,
          selectedIconTheme: const IconThemeData(color: Palette.teal),
          unselectedIconTheme: const IconThemeData(color: Palette.lightPurple),
          elevation: 15,
          onTap: (int index) {
            setState(() {
              _selectedIndex =
                  index; // Update the selected index when an item is tapped
            });
          },
          items: const [
            BottomNavigationBarItem(
                label: "Home", icon: Icon(Icons.headphones)),
            BottomNavigationBarItem(
                label: "Earth", icon: Icon(Icons.headphones))
          ])*/
      ,
      body: Stack(children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.3,
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
          gradient: Palette.navGradient4,
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
      return Container();
    }
  }
}
