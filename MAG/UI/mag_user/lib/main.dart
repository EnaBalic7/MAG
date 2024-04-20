import 'package:flutter/material.dart';
import 'package:mag_user/providers/anime_watchlist_provider.dart';
import 'package:mag_user/providers/watchlist_provider.dart';
import 'package:provider/provider.dart';

import '../providers/anime_provider.dart';
import '../providers/club_provider.dart';
import '../providers/comment_provider.dart';
import '../providers/genre_anime_provider.dart';
import '../providers/genre_provider.dart';
import '../providers/post_provider.dart';
import '../providers/qa_category_provider.dart';
import '../providers/qa_provider.dart';
import '../providers/rating_provider.dart';
import '../providers/role_provider.dart';
import '../providers/user_profile_picture_provider.dart';
import '../providers/user_provider.dart';
import '../providers/user_role_provider.dart';
import '../screens/login_screen.dart';
import './utils/colors.dart';
import './utils/util.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AnimeProvider()),
    ChangeNotifierProvider(create: (_) => GenreProvider()),
    ChangeNotifierProvider(create: (_) => GenreAnimeProvider()),
    ChangeNotifierProvider(create: (_) => QAProvider()),
    ChangeNotifierProvider(create: (_) => QAcategoryProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => UserProfilePictureProvider()),
    ChangeNotifierProvider(create: (_) => RatingProvider()),
    ChangeNotifierProvider(create: (_) => PostProvider()),
    ChangeNotifierProvider(create: (_) => CommentProvider()),
    ChangeNotifierProvider(create: (_) => ClubProvider()),
    ChangeNotifierProvider(create: (_) => RoleProvider()),
    ChangeNotifierProvider(create: (_) => UserRoleProvider()),
    ChangeNotifierProvider(create: (_) => AnimeWatchlistProvider()),
    ChangeNotifierProvider(create: (_) => WatchlistProvider()),
  ], child: const MyMaterialApp()));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Anime Galaxy',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primarySwatch: generateMaterialColor(Palette.darkPurple),
        scaffoldBackgroundColor: Palette.midnightPurple,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Palette.lightPurple,
              displayColor: const Color.fromARGB(255, 90, 83, 155),
              decorationColor: Palette.lightPurple,
            ),
        chipTheme: const ChipThemeData(
          padding: EdgeInsets.all(10),
          selectedColor: Palette.teal,
          checkmarkColor: Palette.midnightPurple,
          backgroundColor: Palette.textFieldPurple,
        ),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Palette.lightPurple,
            selectionColor: Palette.disabledControl,
            selectionHandleColor: Colors.transparent),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Palette.lightPurple,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Palette.teal.withOpacity(0.5),
                textStyle: const TextStyle(color: Palette.white))),
        drawerTheme: DrawerThemeData(
          backgroundColor: Palette.midnightPurple,
          scrimColor: Palette.black.withOpacity(0.3),
        ),
        iconTheme: const IconThemeData(color: Palette.lightPurple),
        scrollbarTheme: ScrollbarThemeData(
            crossAxisMargin: -10,
            thickness: MaterialStateProperty.all(7),
            trackBorderColor: MaterialStateProperty.all(Palette.white),
            thumbColor: MaterialStateProperty.all(
                Palette.lightPurple.withOpacity(0.5))),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Palette.darkPurple,
            labelStyle: TextStyle(color: Palette.lightPurple),
            helperStyle: TextStyle(color: Palette.lightPurple)),
      ),
      home: LoginScreen(),
    );
  }
}
