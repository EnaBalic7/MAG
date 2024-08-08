import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/registration_screen.dart';
import '../models/user_role.dart';
import '../providers/anime_provider.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_field.dart';
import 'anime_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimeProvider _animeProvider;
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _animeProvider = context.read<AnimeProvider>();
    _userProvider = context.read<UserProvider>();

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
                  Image.asset("assets/images/logo.png", width: 220),
                  const SizedBox(height: 40),
                  MyTextField(
                      hintText: "Username",
                      fillColor: Palette.textFieldPurple.withOpacity(0.5),
                      obscureText: false,
                      width: 417,
                      height: 38,
                      borderRadius: 50,
                      controller: _usernameController),
                  const SizedBox(height: 20),
                  MyTextField(
                    hintText: "Password",
                    fillColor: Palette.textFieldPurple.withOpacity(0.5),
                    obscureText: true,
                    width: 417,
                    height: 38,
                    borderRadius: 50,
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
                          var admin = await _userProvider.get(filter: {
                            "RolesIncluded": "true",
                            "Username": username
                          });
                          List<UserRole> userRoles =
                              admin.result.first.userRoles!;

                          if (userRoles
                              .any((userRole) => userRole.roleId == 1)) {
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AnimeScreen()));
                            });
                          } else {
                            Future.delayed(Duration.zero, () {
                              showInfoDialog(
                                  context,
                                  const Icon(Icons.warning_rounded,
                                      color: Palette.lightRed, size: 55),
                                  const SizedBox(
                                    width: 300,
                                    child: Text(
                                      "User is registered but does not have administrator privileges.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                            });
                          }
                        } on Exception catch (e) {
                          Future.delayed(Duration.zero, () {
                            showInfoDialog(
                                context,
                                const Icon(Icons.warning_rounded,
                                    color: Palette.lightRed, size: 55),
                                SizedBox(
                                  width: 300,
                                  child: (e.toString().contains("Unauthorized"))
                                      ? Text(
                                          "Username or password is incorrect, or the user is not registered.\n\n ${e.toString()}",
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          e.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                ));
                          });
                        }
                      },
                      width: 110,
                      height: 32,
                      borderRadius: 50,
                      gradient: Palette.buttonGradient,
                      child: const Text("Log In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Palette.white))),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => const RegistrationScreen()));
                      },
                      child: const Text("Not registered?",
                          style: TextStyle(
                              color: Palette.lightPurple,
                              fontWeight: FontWeight.normal)),
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
