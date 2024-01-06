import 'package:flutter/material.dart';
import 'package:mag_admin/providers/anime_provider.dart';
import 'package:mag_admin/providers/club_provider.dart';
import 'package:mag_admin/providers/comment_provider.dart';
import 'package:mag_admin/providers/genre_anime_provider.dart';
import 'package:mag_admin/providers/genre_provider.dart';
import 'package:mag_admin/providers/post_provider.dart';
import 'package:mag_admin/providers/qa_category_provider.dart';
import 'package:mag_admin/providers/qa_provider.dart';
import 'package:mag_admin/providers/rating_provider.dart';
import 'package:mag_admin/providers/role_provider.dart';
import 'package:mag_admin/providers/user_profile_picture_provider.dart';
import 'package:mag_admin/providers/user_provider.dart';
import 'package:mag_admin/providers/user_role_provider.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/text_field.dart';
import 'package:provider/provider.dart';
import './screens/anime_screen.dart';
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
  ], child: const MyMaterialApp()));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Anime Galaxy',
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
            selectionColor: Palette.midnightPurple,
            selectionHandleColor: Palette.midnightPurple),
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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final AnimeProvider _animeProvider;

  @override
  Widget build(BuildContext context) {
    _animeProvider = context.read<AnimeProvider>();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
            ),
          ),
          Center(
            child: Container(
              width: 518,
              height: 500,
              constraints: const BoxConstraints(maxHeight: 500, maxWidth: 518),
              decoration: BoxDecoration(
                  color: Palette.darkPurple.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Image.asset("assets/images/logo2.png"),
                  const SizedBox(height: 40),
                  MyTextField(
                      hintText: "Username",
                      fillColor: Palette.textFieldPurple.withOpacity(0.9),
                      obscureText: false,
                      width: 417,
                      height: 38,
                      borderRadius: 15,
                      controller: _usernameController),
                  const SizedBox(height: 20),
                  MyTextField(
                    hintText: "Password",
                    fillColor: Palette.textFieldPurple.withOpacity(0.9),
                    obscureText: true,
                    width: 417,
                    height: 38,
                    borderRadius: 15,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 40),
                  GradientButton(
                      onPressed: () async {
                        var username = _usernameController.text;
                        var password = _passwordController.text;
                        print("Login proceed: $username $password");

                        Authorization.username = username;
                        Authorization.password = password;

                        try {
                          await _animeProvider.get();

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const AnimeScreen()));
                        } on Exception catch (e) {
                          showErrorDialog(context, e);
                        }
                      },
                      width: 110,
                      height: 35,
                      borderRadius: 50,
                      gradient: Palette.buttonGradient,
                      child: const Text("Log In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
