import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/colors.dart';

class TempCode extends StatefulWidget {
  const TempCode({Key? key}) : super(key: key);

  @override
  State<TempCode> createState() => _TempCodeState();
}

class _TempCodeState extends State<TempCode> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderCheckboxGroup(
          name: "Test",
          options: [
            FormBuilderFieldOption(value: "Action"),
            FormBuilderFieldOption(value: "Mystery"),
            FormBuilderFieldOption(value: "Drama"),
            FormBuilderFieldOption(value: "Award Winning"),
            FormBuilderFieldOption(value: "Sci-Fi"),
          ],
          decoration: InputDecoration(fillColor: Palette.midnightPurple),
        ),
      ],
    );
  }
}
