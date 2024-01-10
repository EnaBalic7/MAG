import 'package:flutter/material.dart';
import 'package:mag_admin/screens/registration_screen.dart';
import 'package:provider/provider.dart';

import '../providers/anime_provider.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_field.dart';
import 'anime_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimeProvider _animeProvider;

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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => RegistrationScreen()));
                      },
                      child: const Text("Not registered?",
                          style: TextStyle(
                              color: Palette.lightPurple,
                              fontWeight: FontWeight.normal)),
                      onHover: (x) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
