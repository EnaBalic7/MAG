import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:mag_user/screens/nebula_screen.dart';
import 'package:mag_user/screens/test_screen.dart';
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
  bool? showTabBar;
  TabController? tabController;
  List<Widget>? tabs;
  bool? showNavBar;

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
    this.showTabBar = false,
    this.tabController,
    this.tabs,
    this.showNavBar = true,
  }) : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  bool? removeAppBar;
  late UserProvider _userProvider;
  int _selectedIndex = 0;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double appBarHeight = (widget.showTabBar == true)
        ? screenSize.height * 0.12
        : screenSize.height * 0.08;

    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      appBar: AppBarWithSearchSwitch(
        toolbarHeight: appBarHeight,
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
            centerTitle: true,
            leading: _buildLeading(context),
            title: widget.titleWidget ?? Text(widget.title ?? ""),
            actions: _buildActions,
            iconTheme: const IconThemeData(color: Palette.lightPurple),
            bottom: _buildTabBar(),
          );
        },
      ),
      bottomNavigationBar: _buildNavigationBar(),
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

  ResponsiveNavigationBar? _buildNavigationBar() {
    return (widget.showNavBar == true)
        ? ResponsiveNavigationBar(
            backgroundColor: Palette.darkPurple,
            backgroundOpacity: 1,
            activeIconColor: Palette.white,
            inactiveIconColor: Palette.lightPurple,
            fontSize: 25,
            padding: const EdgeInsets.all(4),
            showActiveButtonText: false,
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

              if (_selectedIndex == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TestScreen(),
                  ),
                );
              } else if (_selectedIndex == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NebulaScreen(),
                  ),
                );
              }
            },
            navigationBarButtons: <NavigationBarButton>[
              NavigationBarButton(
                text: 'Home',
                icon: buildEarthIcon(returnIconData: true),
                backgroundGradient: Palette.navGradient1,
              ),
              NavigationBarButton(
                text: 'My Nebula',
                icon: buildNebulaIcon(returnIconData: true),
                backgroundGradient: Palette.navGradient2,
              ),
              NavigationBarButton(
                text: 'Explore',
                icon: buildExploreIcon(returnIconData: true),
                backgroundGradient: Palette.navGradient3,
                padding: const EdgeInsets.all(10),
              ),
              NavigationBarButton(
                text: 'Constellation',
                icon: buildConstellationIcon(returnIconData: true),
                backgroundGradient: Palette.navGradient4,
                padding: const EdgeInsets.only(
                    right: 31, left: 10, top: 10, bottom: 10),
              ),
              NavigationBarButton(
                text: 'Clubs',
                icon: buildClubsIcon(returnIconData: true),
                backgroundGradient: Palette.navGradient5,
              ),
            ],
          )
        : null;
  }

  TabBar? _buildTabBar() {
    return (widget.showTabBar == true)
        ? TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: widget.tabController,
            labelColor: Palette.white,
            unselectedLabelColor: Palette.lightPurple,
            labelPadding: EdgeInsets.all(5),
            tabs: widget.tabs ?? [],
            indicator: const BoxDecoration(
                gradient: Palette.navGradient4,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
          )
        : null;
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
