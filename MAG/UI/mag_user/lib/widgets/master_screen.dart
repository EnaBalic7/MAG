import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass/glass.dart';
import 'package:mag_user/screens/clubs_screen.dart';
import 'package:mag_user/screens/constellation_screen.dart';
import 'package:mag_user/screens/explore_screen.dart';
import 'package:mag_user/screens/nebula_screen.dart';
import 'package:mag_user/screens/home_screen.dart';
import 'package:mag_user/screens/testing.dart';
import 'package:mag_user/widgets/user_profile_dialog.dart';
import 'package:provider/provider.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/help_screen.dart';
import '../screens/profile_screen.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import 'gradient_button.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? titleWidget;

  /// Controller for search
  TextEditingController? controller;

  /// onSubmitted event for search
  void Function(String)? onSubmitted;

  /// onClosed event for search
  void Function()? onClosed;

  /// onChanged event for search
  void Function(String)? onChanged;

  /// onCleared event for search
  void Function()? onCleared;

  void Function()? floatingButtonOnPressed;
  bool? showBackArrow;
  bool? showSearch;
  bool? showFloatingActionButton;
  Widget? floatingActionButtonIcon;

  /// This widget will be used for floatingActionButton
  GradientButton? gradientButton;
  bool? showProfileIcon;
  String? floatingButtonTooltip;
  bool? showTabBar;
  TabController? tabController;
  List<Widget>? tabs;
  bool? showNavBar;
  int? selectedIndex;

  /// If set to true, it makes tabs scrollable horizontally
  bool? isScrollable;

  /// Border radius for TabBar tabs
  BorderRadius? borderRadius;

  /// Padding around tabs' labels
  EdgeInsets? labelPadding;

  /// Floating action button location
  FloatingActionButtonLocation? floatingActionButtonLocation;

  bool? showHelpIcon;

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
    this.selectedIndex,
    this.isScrollable,
    this.borderRadius,
    this.labelPadding,
    this.floatingActionButtonLocation,
    this.showHelpIcon,
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
      floatingActionButtonLocation: widget.floatingActionButtonLocation ??
          FloatingActionButtonLocation.endFloat,
      appBar: AppBarWithSearchSwitch(
        toolbarHeight: appBarHeight,
        closeOnSubmit: true,
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
            selectedIndex: (widget.selectedIndex != null)
                ? widget.selectedIndex!
                : _selectedIndex,
            onTabChange: (index) {
              setState(() {
                widget.selectedIndex = index;
                _selectedIndex = index;
              });

              switch (index) {
                case 0:
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => HomeScreen(selectedIndex: index)));
                  break;
                case 1:
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => NebulaScreen(selectedIndex: index)));
                  break;
                case 2:
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => ExploreScreen(selectedIndex: index)));
                  break;
                case 3:
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => ConstellationScreen(
                            selectedIndex: index,
                          )));
                  break;
                case 4:
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => TestingScreen(selectedIndex: index)));
                  break;
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
            isScrollable: widget.isScrollable ?? false,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: widget.tabController,
            labelColor: Palette.white,
            unselectedLabelColor: Palette.lightPurple,
            labelPadding: widget.labelPadding ?? const EdgeInsets.all(5),
            tabs: widget.tabs ?? [],
            indicator: BoxDecoration(
                gradient: Palette.navGradient4,
                borderRadius: widget.borderRadius ??
                    const BorderRadius.only(
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
          width: 60,
          height: 60,
          borderRadius: 100,
          onPressed: widget.floatingButtonOnPressed,
          gradient: Palette.navGradient2,
          child: widget.floatingActionButtonIcon ??
              const Icon(Icons.add_rounded, size: 40, color: Palette.white)),
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
      actions.add(IconButton(
          splashRadius: 24,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return UserProfileDialog(
                  loggedUser: LoggedUser.user!,
                );
              },
            );
          },
          icon: buildAstronautIcon()));
    }

    return actions;
  }

  Widget _buildLeading(BuildContext context) {
    if (widget.showBackArrow == true) {
      return IconButton(
        splashRadius: 24,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Palette.lightPurple,
        ),
      );
    } else if (widget.showHelpIcon == true) {
      return IconButton(
        splashRadius: 24,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HelpScreen()));
        },
        icon: buildHelpIcon(24),
      );
    } else {
      return Container();
    }
  }
}
