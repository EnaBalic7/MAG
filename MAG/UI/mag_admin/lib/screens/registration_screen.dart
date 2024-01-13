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
  final _formKey = GlobalKey<FormBuilderState>();
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
              width: 618,
              height: 520,
              constraints: const BoxConstraints(maxHeight: 600, maxWidth: 918),
              decoration: BoxDecoration(
                  color: Palette.darkPurple.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo2.png",
                    width: 155,
                  ),
                  const SizedBox(height: 20),
                  FormBuilder(
                      key: _formKey,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          MyFormBuilderTextField(
                            name: "username",
                            labelText: "Username",
                            fillColor: Palette.textFieldPurple.withOpacity(0.4),
                            width: 250,
                            height: 40,
                            paddingBottom: 25,
                            borderRadius: 50,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                          const SizedBox(width: 40),
                          MyFormBuilderTextField(
                            name: "email",
                            labelText: "E-mail",
                            fillColor: Palette.textFieldPurple.withOpacity(0.4),
                            width: 250,
                            height: 40,
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
                            width: 250,
                            height: 40,
                            paddingBottom: 25,
                            borderRadius: 50,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                          const SizedBox(width: 40),
                          MyFormBuilderTextField(
                            name: "lastName",
                            labelText: "Last name",
                            fillColor: Palette.textFieldPurple.withOpacity(0.4),
                            width: 250,
                            height: 40,
                            paddingBottom: 25,
                            borderRadius: 50,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                          MyFormBuilderTextField(
                            name: "password",
                            labelText: "Password",
                            fillColor: Palette.textFieldPurple.withOpacity(0.4),
                            width: 400,
                            height: 40,
                            paddingBottom: 25,
                            borderRadius: 50,
                            obscureText: true,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "This field cannot be empty.";
                              } else if (val.length < 8) {
                                return 'Password is too short.';
                              } else if (containsNumbers(val) == false) {
                                return 'Password must contain at least one number';
                              } else if (containsUppercase(val) == false) {
                                return 'Password must contain at least one uppercase letter.';
                              } else if (containsLowercase(val) == false) {
                                return 'Password must contain at least one lowercase letter.';
                              }
                              return null;
                            },
                          ),
                          MyFormBuilderTextField(
                            name: "passwordConfirmation",
                            labelText: "Repeat password",
                            fillColor: Palette.textFieldPurple.withOpacity(0.4),
                            width: 400,
                            height: 40,
                            paddingBottom: 25,
                            borderRadius: 50,
                            obscureText: true,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "This field cannot be empty.";
                              } else if (_formKey.currentState
                                      ?.fields['password']?.value !=
                                  val) {
                                return "Passwords do not match.";
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  GradientButton(
                      onPressed: () async {
                        if (_formKey.currentState?.saveAndValidate() == true) {
                          print("No validation errors.");
                        } else {
                          print("There are validation errors.");
                        }
                      },
                      width: 110,
                      height: 35,
                      borderRadius: 50,
                      gradient: Palette.buttonGradient,
                      child: const Text("Register",
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
