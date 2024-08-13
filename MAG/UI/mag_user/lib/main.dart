import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import '../providers/club_cover_provider.dart';
import '../providers/club_user_provider.dart';
import '../providers/donation_provider.dart';
import '../providers/payment_intent_provider.dart';
import '../providers/preferred_genre_provider.dart';
import '../providers/user_comment_action_provider.dart';
import '../providers/user_post_action_provider.dart';
import '../providers/anime_list_provider.dart';
import '../providers/anime_watchlist_provider.dart';
import '../providers/listt_provider.dart';
import '../providers/watchlist_provider.dart';
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

void main() async {
  await dotenv.load(fileName: "assets/.env");

  String stripePK = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;

  Stripe.publishableKey =
      String.fromEnvironment('STRIPE_PUBLISHABLE_KEY', defaultValue: stripePK);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AnimeProvider()),
    ChangeNotifierProvider(create: (_) => GenreProvider()),
    ChangeNotifierProvider(create: (_) => GenreAnimeProvider()),
    ChangeNotifierProvider(create: (_) => QAProvider()),
    ChangeNotifierProvider(create: (_) => QAcategoryProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => UserProfilePictureProvider()),
    ChangeNotifierProvider(create: (_) => RatingProvider()),
    ChangeNotifierProvider(create: (_) => UserPostActionProvider()),
    ChangeNotifierProvider(
        create: (context) => PostProvider(
            userPostActionProvider: context.read<UserPostActionProvider>())),
    ChangeNotifierProvider(create: (_) => UserCommentActionProvider()),
    ChangeNotifierProvider(
        create: (context) => CommentProvider(
            userCommentActionProvider:
                context.read<UserCommentActionProvider>())),
    ChangeNotifierProvider(create: (_) => ClubProvider()),
    ChangeNotifierProvider(create: (_) => RoleProvider()),
    ChangeNotifierProvider(create: (_) => UserRoleProvider()),
    ChangeNotifierProvider(create: (_) => AnimeWatchlistProvider()),
    ChangeNotifierProvider(create: (_) => WatchlistProvider()),
    ChangeNotifierProvider(create: (_) => ListtProvider()),
    ChangeNotifierProvider(create: (_) => AnimeListProvider()),
    ChangeNotifierProvider(create: (_) => ClubCoverProvider()),
    ChangeNotifierProvider(create: (_) => ClubUserProvider()),
    ChangeNotifierProvider(create: (_) => PreferredGenreProvider()),
    ChangeNotifierProvider(create: (_) => PaymentIntentProvider()),
    ChangeNotifierProvider(create: (_) => DonationProvider()),
  ], child: const MyMaterialApp()));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

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
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: MyCustomPageTransitionBuilder(),
            TargetPlatform.iOS: MyCustomPageTransitionBuilder(),
          },
        ),
        chipTheme: const ChipThemeData(
          padding: EdgeInsets.all(8),
          selectedColor: Palette.rose,
          checkmarkColor: Palette.midnightPurple,
          backgroundColor: Palette.textFieldPurple,
          labelPadding: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 0,
            bottom: 0,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Palette.lightPurple,
            selectionColor: Palette.midnightPurple.withOpacity(0.6),
            selectionHandleColor: Colors.transparent),
        appBarTheme: const AppBarTheme(
            backgroundColor: Palette.darkPurple,
            titleTextStyle: TextStyle(
                color: Palette.lightPurple,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                iconColor: Palette.white,
                backgroundColor: Palette.teal.withOpacity(0.5),
                textStyle: const TextStyle(color: Palette.white))),
        drawerTheme: DrawerThemeData(
          backgroundColor: Palette.midnightPurple,
          scrimColor: Palette.black.withOpacity(0.3),
        ),
        iconTheme: const IconThemeData(color: Palette.lightPurple),
        scrollbarTheme: ScrollbarThemeData(
            crossAxisMargin: -10,
            thickness: WidgetStateProperty.all(7),
            trackBorderColor: WidgetStateProperty.all(Palette.white),
            thumbColor:
                WidgetStateProperty.all(Palette.lightPurple.withOpacity(0.5))),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Palette.darkPurple,
            labelStyle: TextStyle(color: Palette.lightPurple),
            helperStyle: TextStyle(color: Palette.lightPurple)),
      ),
      home: const LoginScreen(),
    );
  }
}

class MyCustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
