import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/providers/user_profile_picture_provider.dart';
import 'package:provider/provider.dart';

import '../providers/anime_provider.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/form_builder_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_field.dart';
import 'anime_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              constraints: const BoxConstraints(maxHeight: 500, maxWidth: 518),
              decoration: BoxDecoration(
                  color: Palette.darkPurple.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  FormBuilder(
                      child: Column(
                    children: [
                      MyFormBuilderTextField(
                        name: "username",
                        labelText: "Username",
                        fillColor: Palette.textFieldPurple.withOpacity(0.4),
                        width: 400,
                        height: 50,
                        paddingBottom: 25,
                        borderRadius: 50,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      MyFormBuilderTextField(
                        name: "firstName",
                        labelText: "First name",
                        fillColor: Palette.textFieldPurple.withOpacity(0.4),
                        width: 400,
                        height: 50,
                        paddingBottom: 25,
                        borderRadius: 50,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      MyFormBuilderTextField(
                        name: "lastName",
                        labelText: "Last name",
                        fillColor: Palette.textFieldPurple.withOpacity(0.4),
                        width: 400,
                        height: 50,
                        paddingBottom: 25,
                        borderRadius: 50,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                    ],
                  )),
                  GradientButton(
                      onPressed: () async {
                        try {
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
                        Navigator.pop(context);
                      },
                      child: const Text("Back",
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
