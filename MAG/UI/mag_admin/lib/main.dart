import 'package:flutter/material.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import './screens/anime_screen.dart';
import './utils/colors.dart';
import './utils/util.dart';

void main() {
  runApp(const MyMaterialApp());
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
          listTileTheme:
              ListTileThemeData(selectedTileColor: Palette.starYellow)),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Stack(
        children: [
          Center(
            child: Container(
              child: Column(
                children: [
                  Text("Click on button below to see Anime screen:"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AnimeScreen()));
                      },
                      child: Text("Anime screen"))
                ],
              ),
            ),
          ),
        ],
      ),
      title_widget: Text("Login page"),
    );
  }
}
