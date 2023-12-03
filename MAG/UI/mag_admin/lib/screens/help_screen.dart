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
import '../utils/util.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  ScrollController scrollController = ScrollController();
  late QAProvider _qaProvider;
  late Future<SearchResult<QA>> _qaFuture;
  Map<String, dynamic> _initialValue = {};
  int? qaID;

  final _QAFormKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _qaProvider = context.read<QAProvider>();
    _qaFuture = _qaProvider
        .get(filter: {"UserIncluded": "true", "CategoryIncluded": "true"});

    _initialValue = {
      "answer": "",
      "question": "",
      "displayed": true,
    };
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
                  key: _QAFormKey,
                  initialValue: _initialValue,
                  child: MyFormBuilderTextField(
                    name: "answer",
                    fillColor: Palette.darkPurple,
                    width: 500,
                    height: 600,
                    borderRadius: 15,
                    minLines: 40,
                    maxLines: 40,
                    borderColor: Palette.lightPurple.withOpacity(0.3),
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
                onPressed: () async {
                  _QAFormKey.currentState?.saveAndValidate();
                  var tmp = Map.from(_QAFormKey.currentState!.value);
                  var request = {
                    "answer": tmp["answer"].toString(),
                    "question": _initialValue["question"].toString(),
                    "displayed": true,
                  };
                  try {
                    if (qaID != null) {
                      await _qaProvider.update(qaID!, request: request);
                      showInfoDialog(
                          context,
                          Icon(Icons.task_alt,
                              color: Palette.lightPurple, size: 50),
                          Text(
                            "Answered successfully!",
                            textAlign: TextAlign.center,
                          ));
                    }
                  } on Exception catch (e) {
                    showErrorDialog(context, e);
                  }
                },
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
                  child: Text(qa.question.toString(),
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                Container(
                    child: Row(
                  children: [
                    IconButton(
                        constraints:
                            BoxConstraints(maxHeight: 24, maxWidth: 24),
                        alignment: Alignment.topCenter,
                        tooltip: "Add or edit answer",
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        padding: EdgeInsets.zero,
                        splashRadius: 0.1,
                        onPressed: () {
                          setState(() {
                            _initialValue["question"] = qa.question.toString();
                            qaID = qa.id;
                            _QAFormKey.currentState!.fields["answer"]!
                                .didChange(qa.answer.toString());
                          });
                        },
                        icon: buildEditIcon(24)),
                    SizedBox(width: 10),
                    IconButton(
                        constraints:
                            BoxConstraints(maxHeight: 24, maxWidth: 24),
                        alignment: Alignment.topCenter,
                        tooltip: "Delete question",
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        padding: EdgeInsets.zero,
                        splashRadius: 0.1,
                        onPressed: () {},
                        icon: buildTrashIcon(24)),

                    /* GestureDetector(
                        onTap: () {},
                        child: MouseRegion(child: buildEditIcon(24))),
                    GestureDetector(
                        onTap: () {},
                        child: MouseRegion(child: buildTrashIcon(24))),*/
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
                                size: 19, color: Palette.lightPurple),
                            SizedBox(width: 5),
                            Text(qa.user.username.toString()),
                          ],
                        ),
                        GradientButton(
                            contentPaddingLeft: 5,
                            contentPaddingRight: 5,
                            contentPaddingBottom: 1,
                            contentPaddingTop: 0,
                            borderRadius: 50,
                            gradient: Palette.menuGradient,
                            child: Text(
                              qa.category.name.toString(),
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
                constraints: BoxConstraints(minHeight: 30, maxHeight: 100),
                //height: 100,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Text(
                    qa.answer.toString(),
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
