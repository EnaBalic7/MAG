import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/widgets/form_builder_text_field.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';

import '../utils/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        child: Center(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 40),
                child: FormBuilder(
                  child: MyFormBuilderTextField(
                    name: "test",
                    fillColor: Palette.darkPurple,
                    width: 500,
                    height: 600,
                    borderRadius: 15,
                    minLines: 40,
                    maxLines: 40,
                    borderColor: Palette.lightPurple.withOpacity(0.3),
                    initialValue:
                        "We do not have plans to implement a light mode. The way to create your own list is the following: \nYou go to the suitabke screen, and click some buttons, and then poof - Magic happens. Have you ever wondered about complexities of life? For example, why do magicians flaunt shiny things? Word's around they do it when there is something else they don't want you to see.",
                  ),
                ),
              ),
              GradientButton(
                paddingLeft: 15,
                paddingTop: 30,
                width: 100,
                height: 30,
                borderRadius: 50,
                gradient: Palette.buttonGradient,
                child: Text("Save",
                    style: TextStyle(
                        color: Palette.midnightPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: 15)),
              ),
            ],
          ),
          Column(
            children: [
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 40),
                    child: Container(
                      width: 450,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Palette.darkPurple),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("How can I solve this issue?"),
                            Container(
                                child: Row(
                              children: [
                                Icon(Icons.heart_broken),
                                Icon(Icons.heart_broken_outlined)
                              ],
                            ))
                          ],
                        ),
                        Row(
                          children: [Text("Nezuko Kamado")],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "We do not have plans to implement a light mode. The way to create your own list is the following: \nYou go to the suitabke screen, and click some buttons, and then poof - Magic happens. Have you ever wondered about complexities of life? For example, why do magicians flaunt shiny things? Word's around they do it when there is something else they don't want you to see.",
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
