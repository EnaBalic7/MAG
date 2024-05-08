import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glass/glass.dart';
import 'package:mag_user/models/qa_category.dart';
import 'package:mag_user/providers/qa_category_provider.dart';
import 'package:mag_user/widgets/form_builder_dropdown.dart';
import 'package:mag_user/widgets/form_builder_text_field.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/gradient_button.dart';

class MyQuestionsScreen extends StatefulWidget {
  const MyQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<MyQuestionsScreen> createState() => _MyQuestionsScreenState();
}

class _MyQuestionsScreenState extends State<MyQuestionsScreen> {
  final _questionFormKey = GlobalKey<FormBuilderState>();
  late final _QAcategoryProvider;
  late Future<SearchResult<QAcategory>> _QAcategoryFuture;
  String? category = "1";

  @override
  void initState() {
    _QAcategoryProvider = context.read<QAcategoryProvider>();
    _QAcategoryFuture = _QAcategoryProvider.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Have a question? Ask away ~",
                  style: TextStyle(fontSize: 17)),
            ),
            FormBuilder(
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: MyFormBuilderTextField(
                      name: "question",
                      minLines: 10,
                      fillColor: Palette.textFieldPurple.withOpacity(0.3),
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      borderRadius: 15,
                      errorBorderRadius: 15,
                      validator: (val) {
                        if (val != null &&
                            val.isNotEmpty &&
                            !isValidReviewText(val)) {
                          return "Some special characters are not allowed.";
                        } else if (val != null &&
                            val.isNotEmpty &&
                            val.length > 420) {
                          return "Exceeded character limit: ${val.length}/420";
                        }
                        return null;
                      },
                    ).asGlass(
                      blurX: 5,
                      blurY: 5,
                      clipBorderRadius: BorderRadius.circular(15),
                      tintColor: Palette.textFieldPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<SearchResult<QAcategory>>(
                      future: _QAcategoryFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const MyProgressIndicator(); // Loading state
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Error state
                        } else {
                          // Data loaded successfully
                          var qaCategoryList = snapshot.data!.result;

                          return Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Palette.textFieldPurple.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: DropdownButton<String>(
                                isDense: true,
                                underline: Container(),
                                icon: const Icon(Icons.arrow_drop_down_rounded,
                                    color: Palette.lightPurple),
                                value: category,
                                borderRadius: BorderRadius.circular(15),
                                dropdownColor: Palette.buttonPurple,
                                items: qaCategoryList
                                    .map(
                                      (qaCategory) => DropdownMenuItem(
                                        value: "${qaCategory.id}",
                                        child: Center(
                                            child: Text("${qaCategory.name}")),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    category = val;
                                  });
                                }),
                          ).asGlass(
                              blurX: 5,
                              blurY: 5,
                              tintColor: Palette.buttonPurple,
                              clipBorderRadius: BorderRadius.circular(50));

                          /* return Container(
                            child: MyFormBuilderDropdown(
                              name: "category",
                              labelText: "Category",
                              initialValue: "1",
                              width: 300,
                              borderRadius: 50,
                              height: 50,
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Palette.lightPurple,
                                  size: 28,
                                ),
                              ),
                              fillColor:
                                  Palette.textFieldPurple.withOpacity(0.5),
                              dropdownColor: Palette.buttonPurple,
                              items: qaCategoryList
                                  .map(
                                    (qaCategory) => DropdownMenuItem(
                                      value: "${qaCategory.id}",
                                      child: Text("${qaCategory.name}"),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );*/
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GradientButton(
                onPressed: () {
                  // Implement adding a question
                },
                width: 90,
                height: 30,
                borderRadius: 50,
                gradient: Palette.buttonGradient,
                child: const Text("Submit",
                    style: TextStyle(fontWeight: FontWeight.w500))),
          ],
        )
      ],
    );
  }
}
