import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/providers/qa_provider.dart';
import 'package:mag_admin/utils/icons.dart';
import 'package:mag_admin/widgets/form_builder_dropdown.dart';
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
  String? _questionTitle = "";
  final _QAFormKey = GlobalKey<FormBuilderState>();
  final _QAfilterFormKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _selectedQAFilter = {"QAfilter": "All"};

  @override
  void initState() {
    super.initState();
    _qaProvider = context.read<QAProvider>();
    _qaFuture = _qaProvider.get(filter: {
      "UserIncluded": "true",
      "CategoryIncluded": "true",
      "NewestFirst": "true"
    });

    _initialValue = {
      "answer": "",
      "question": "",
      "displayed": true,
    };

    context.read<QAProvider>().addListener(() {
      _reloadQAList();
    });
  }

  void _reloadQAList() {
    if (mounted) {
      if (_selectedQAFilter == "All") {
        setState(() {
          _qaFuture = context.read<QAProvider>().get(filter: {
            "UserIncluded": "true",
            "CategoryIncluded": "true",
            "NewestFirst": "true"
          });
        });
      } else if (_selectedQAFilter == "Unanswered") {
        setState(() {
          _qaFuture = context.read<QAProvider>().get(filter: {
            "UserIncluded": "true",
            "CategoryIncluded": "true",
            "NewestFirst": "true",
            "UnansweredOnly": "true"
          });
        });
      } else if (_selectedQAFilter == "Hidden") {
        setState(() {
          _qaFuture = context.read<QAProvider>().get(filter: {
            "UserIncluded": "true",
            "CategoryIncluded": "true",
            "NewestFirst": "true",
            "HiddenOnly": "true"
          });
        });
      } else if (_selectedQAFilter == "Displayed") {
        setState(() {
          _qaFuture = context.read<QAProvider>().get(filter: {
            "UserIncluded": "true",
            "CategoryIncluded": "true",
            "NewestFirst": "true",
            "DisplayedOnly": "true"
          });
        });
      }
    }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Text(
                    _questionTitle!,
                    style: TextStyle(
                      fontSize: 17,
                      color: Palette.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 20),
                child: FormBuilder(
                  key: _QAFormKey,
                  initialValue: _initialValue,
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: 400,
                      minWidth: 500,
                      maxWidth: 500,
                    ),
                    child: MyFormBuilderTextField(
                      name: "answer",
                      fillColor: Palette.darkPurple,
                      width: 500,
                      height: 300,
                      borderRadius: 15,
                      minLines: 40,
                      maxLines: 40,
                      borderColor: Palette.lightPurple.withOpacity(0.3),
                    ),
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
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormBuilder(
                            key: _QAfilterFormKey,
                            initialValue: _selectedQAFilter,
                            child: MyFormBuilderDropdown(
                              name: "QAfilter",
                              width: 130,
                              height: 50,
                              borderRadius: 15,
                              paddingRight: 15,
                              onChanged: (filter) {
                                setState(() {
                                  _selectedQAFilter["QAfilter"] =
                                      filter.toString();
                                });
                                _filterQA(filter!);
                              },
                              icon: Icon(Icons.filter_alt,
                                  color: Palette.lightPurple),
                              items: [
                                DropdownMenuItem(
                                    value: 'All', child: Text('All')),
                                DropdownMenuItem(
                                    value: 'Unanswered',
                                    child: Text('Unanswered')),
                                DropdownMenuItem(
                                    value: 'Hidden', child: Text('Hidden')),
                                DropdownMenuItem(
                                    value: 'Displayed',
                                    child: Text('Displayed')),
                              ],
                            ),
                          ),
                          LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            double maxSeparatorWidth =
                                constraints.maxWidth - 100;
                            return Padding(
                              padding: EdgeInsets.only(right: 25),
                              child: Container(
                                height: 1,
                                width: maxSeparatorWidth,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Palette.lightPurple.withOpacity(0.5),
                                ),
                              ),
                            );
                          }),
                          Wrap(
                            children: _buildQACards(qaList),
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                          ),
                        ],
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
        constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
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
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 23),
                  child: Container(
                    padding: EdgeInsets.zero,
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
                                _initialValue["question"] =
                                    qa.question.toString();
                                qaID = qa.id;
                                _questionTitle = qa.question.toString();
                                _QAFormKey.currentState!.fields["answer"]!
                                    .didChange(qa.answer.toString());
                              });
                            },
                            icon: buildEditIcon(24)),
                        PopupMenuButton<String>(
                          tooltip: "More actions",
                          offset: Offset(195, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Palette.lightPurple.withOpacity(0.3)),
                          ),
                          icon: Icon(Icons.more_vert_rounded),
                          splashRadius: 1,
                          padding: EdgeInsets.zero,
                          color: Color.fromRGBO(50, 48, 90, 1),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                hoverColor:
                                    Palette.lightPurple.withOpacity(0.1),
                                leading: _buildHideIcon(qa),
                                title: _buildHideTitle(qa),
                                subtitle: _buildHideSubtitle(qa),
                                onTap: () async {
                                  await _hideOrShowQA(qa, context);
                                },
                              ),
                            ),
                            PopupMenuItem<String>(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                hoverColor: Palette.lightRed.withOpacity(0.1),
                                leading: buildTrashIcon(24),
                                title: Text('Delete',
                                    style: TextStyle(color: Palette.lightRed)),
                                subtitle: Text('Delete permanently',
                                    style: TextStyle(
                                        color:
                                            Palette.lightRed.withOpacity(0.5))),
                                onTap: () async {
                                  await _deleteQA(qa, context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
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
                            Text(qa.user!.username.toString()),
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
                              qa.category!.name.toString(),
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

  Icon _buildHideIcon(QA qa) {
    if (qa.displayed == true) {
      return Icon(Icons.visibility_off_outlined, color: Palette.lightPurple);
    } else {
      return Icon(Icons.visibility_outlined, color: Palette.lightPurple);
    }
  }

  Text _buildHideSubtitle(QA qa) {
    if (qa.displayed == true) {
      return Text('Hide question for users',
          style: TextStyle(color: Palette.lightPurple.withOpacity(0.5)));
    } else {
      return Text('Show question to users',
          style: TextStyle(color: Palette.lightPurple.withOpacity(0.5)));
    }
  }

  Text _buildHideTitle(QA qa) {
    if (qa.displayed == true) {
      return Text('Hide', style: TextStyle(color: Palette.lightPurple));
    } else {
      return Text('Show', style: TextStyle(color: Palette.lightPurple));
    }
  }

  Future<void> _deleteQA(QA qa, BuildContext context) async {
    setState(() {
      qaID = qa.id;
    });

    try {
      if (qaID != null) {
        showConfirmationDialog(
            context,
            Icon(Icons.warning_rounded, color: Palette.lightRed, size: 55),
            Text("Are you sure you want to delete this question?"), () async {
          await _qaProvider.delete(qaID!);
          showInfoDialog(
              context,
              Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
              Text(
                "Question has been deleted.",
                textAlign: TextAlign.center,
              ));
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  Future<void> _hideOrShowQA(QA qa, BuildContext context) async {
    setState(() {
      qaID = qa.id;
    });
    var request = {
      "answer": qa.answer.toString(),
      "question": qa.question.toString(),
      "displayed": (qa.displayed == true) ? false : true,
    };
    try {
      if (qaID != null) {
        await _qaProvider.update(qaID!, request: request);
        showInfoDialog(
            context,
            Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
            Text(
              "Question has been hidden.",
              textAlign: TextAlign.center,
            ));
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  void _filterQA(String filter) {
    if (filter == "All") {
      setState(() {
        _qaFuture = _qaProvider.get(filter: {
          "UserIncluded": "true",
          "CategoryIncluded": "true",
          "NewestFirst": "true",
        });
      });
    } else if (filter == "Unanswered") {
      setState(() {
        _qaFuture = _qaProvider.get(filter: {
          "UserIncluded": "true",
          "CategoryIncluded": "true",
          "NewestFirst": "true",
          "UnansweredOnly": "true"
        });
      });
    } else if (filter == "Hidden") {
      setState(() {
        _qaFuture = _qaProvider.get(filter: {
          "UserIncluded": "true",
          "CategoryIncluded": "true",
          "NewestFirst": "true",
          "HiddenOnly": "true"
        });
      });
    } else if (filter == "Displayed") {
      setState(() {
        _qaFuture = _qaProvider.get(filter: {
          "UserIncluded": "true",
          "CategoryIncluded": "true",
          "NewestFirst": "true",
          "DisplayedOnly": "true"
        });
      });
    }
  }
}
