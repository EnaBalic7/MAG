import 'package:flutter/material.dart';
import 'package:mag_admin/providers/anime_provider.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:mag_admin/widgets/text_field.dart';
import 'package:provider/provider.dart';
import './screens/anime_screen.dart';
import './utils/colors.dart';
import './utils/util.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AnimeProvider())],
      child: const MyMaterialApp()));
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
              displayColor: Palette.lightPurple,
            ),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Palette.lightPurple,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Palette.teal.withOpacity(0.5),
                textStyle: TextStyle(color: Palette.white))),
        drawerTheme: DrawerThemeData(
          backgroundColor: Palette.midnightPurple,
          scrimColor: Palette.black.withOpacity(0.3),
        ),
        iconTheme: IconThemeData(color: Palette.lightPurple),
        scrollbarTheme: ScrollbarThemeData(
            crossAxisMargin: -10,
            thickness: MaterialStateProperty.all(7),
            trackBorderColor: MaterialStateProperty.all(Palette.white),
            thumbColor: MaterialStateProperty.all(
                Palette.lightPurple.withOpacity(0.5))),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  late AnimeProvider _animeProvider;

  @override
  Widget build(BuildContext context) {
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
              constraints: BoxConstraints(maxHeight: 500, maxWidth: 518),
              decoration: BoxDecoration(
                  color: Palette.darkPurple.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Image.asset("assets/images/logo2.png"),
                  MyTextField(
                    labelText: "Username",
                  ),
                  TextField(decoration: InputDecoration(labelText: "Password")),
                  GradientButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const AnimeScreen()));
                      },
                      width: 100,
                      height: 30,
                      borderRadius: 50,
                      gradient: Palette.gradient2,
                      child: Text("Log In")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
