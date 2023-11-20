import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MyDateTimePicker extends StatefulWidget {
  String? name;
  String? labelText;
  DateTime? initialValue;
  Color? fillColor;
  double? width;
  double? height;
  double? borderRadius;
  double? paddingLeft;
  double? paddingRight;
  double? paddingTop;
  double? paddingBottom;
  MyDateTimePicker({
    Key? key,
    required this.name,
    this.width = 100,
    this.height = 40,
    this.labelText,
    this.borderRadius = 0,
    this.paddingLeft = 40,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 50,
    this.initialValue,
    this.fillColor,
  }) : super(key: key);

  @override
  State<MyDateTimePicker> createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.paddingLeft!,
          right: widget.paddingRight!,
          top: widget.paddingTop!,
          bottom: widget.paddingBottom!),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: FormBuilderDateTimePicker(
          valueTransformer: (selectedDate) {
            return selectedDate?.toIso8601String();
          },
          name: widget.name!,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.date_range_rounded,
                size: 24, color: Palette.lightPurple),
            fillColor: widget.fillColor,
            labelText: widget.labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Palette.lightPurple,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
          ),
          inputType: InputType.date,
          format: DateFormat('MMM d, y'),
        ),
      ),
    );
  }
}
