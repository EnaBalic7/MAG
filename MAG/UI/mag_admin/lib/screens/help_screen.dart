import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/providers/qa_provider.dart';
import 'package:mag_admin/utils/icons.dart';
import 'package:mag_admin/widgets/form_builder_text_field.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../models/qa.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  ScrollController scrollController = ScrollController();
  late QAProvider _qaProvider;
  late Future<SearchResult<QA>> _qaFuture;

  @override
  void initState() {
    super.initState();
    _qaProvider = context.read<QAProvider>();
    _qaFuture = _qaProvider.get();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
                        "We do not have plans to implement a light mode. The way to create your own list is the following: \nYou go to the suitable screen, and click some buttons, and then poof - Magic happens. Have you ever wondered about complexities of life? For example, why do magicians flaunt shiny things? Word's around they do it when there is something else they don't want you to see.",
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                controller: scrollController,
                child: FutureBuilder<SearchResult<QA>>(
                  future: _qaFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Loading state
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Error state
                    } else {
                      // Data loaded successfully
                      var qaList = snapshot.data!.result;
                      return Container(
                        child: Column(
                          children: [
                            Wrap(
                              children: _buildQACards(qaList),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  List<Widget> _buildQACards(List<QA> qaList) {
    return List.generate(
      qaList.length,
      (index) => _buildQACard(qaList[index]),
    );
  }

  Widget _buildQACard(QA qa) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 15),
      child: Container(
        width: 450,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                      "How can I solve this issue? Can you explain Constellations to me?",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                Container(
                    child: Row(
                  children: [
                    buildEditIcon(24),
                    SizedBox(width: 10),
                    buildTrashIcon(24),
                  ],
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_rounded,
                                size: 17, color: Palette.lightPurple),
                            SizedBox(width: 5),
                            Text("Nezuko Kamado"),
                          ],
                        ),
                        GradientButton(
                            contentPaddingLeft: 5,
                            contentPaddingRight: 5,
                            contentPaddingBottom: 1,
                            contentPaddingTop: 1,
                            borderRadius: 50,
                            gradient: Palette.menuGradient,
                            child: Text(
                              "General",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Palette.lightPurple,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: 100,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Text(
                    "We do not have plans to implement a light mode. The way to create your own list is the following: \nYou go to the suitable screen, and click some buttons, and then poof - Magic happens. Have you ever wondered about complexities of life? For example, why do magicians flaunt shiny things? Word's around they do it when there is something else they don't want you to see.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
