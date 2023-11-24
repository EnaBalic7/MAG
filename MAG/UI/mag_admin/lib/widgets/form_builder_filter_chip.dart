import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/colors.dart';

class MyFormBuilderFilterChip extends StatefulWidget {
  String? name;
  List<FormBuilderFieldOption<dynamic>>? options;
  String? labelText;
  MyFormBuilderFilterChip({
    Key? key,
    required this.name,
    required this.options,
    this.labelText,
  }) : super(key: key);

  @override
  State<MyFormBuilderFilterChip> createState() =>
      _MyFormBuilderFilterChipState();
}

class _MyFormBuilderFilterChipState extends State<MyFormBuilderFilterChip> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderFilterChip(
      name: widget.name!,
      options: widget.options!,
      decoration: InputDecoration(
        labelText: widget.labelText ?? "",
        fillColor: Colors.transparent,
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Palette.lightPurple,
          height: 0.2,
        ),
        border: InputBorder.none,
      ),
      spacing: 8,
      runSpacing: 12,
    );
  }
}
