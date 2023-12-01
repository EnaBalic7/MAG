import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/utils/icons.dart';
import '../utils/colors.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MyFormBuilderDropdown extends StatefulWidget {
  String name;
  String? labelText;
  Color? fillColor;
  double? width;
  double? height;
  double? borderRadius;
  String? initialValue;
  double? paddingLeft;
  double? paddingRight;
  double? paddingTop;
  double? paddingBottom;
  Widget? icon;
  void Function(Object?)? onChanged;
  MyFormBuilderDropdown({
    Key? key,
    required this.name,
    this.labelText,
    this.fillColor,
    this.width,
    this.height,
    this.borderRadius,
    this.initialValue,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.onChanged,
    this.icon,
  }) : super(key: key);

  @override
  State<MyFormBuilderDropdown> createState() => _MyFormBuilderDropdownState();
}

class _MyFormBuilderDropdownState extends State<MyFormBuilderDropdown> {
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
        child: FormBuilderDropdown(
          icon: widget.icon,
          dropdownColor: Palette.darkPurple,
          items: [
            DropdownMenuItem(value: 'Spring', child: Text('Spring')),
            DropdownMenuItem(value: 'Summer', child: Text('Summer')),
            DropdownMenuItem(value: 'Fall', child: Text('Fall')),
            DropdownMenuItem(value: 'Winter', child: Text('Winter')),
          ],
          onChanged: widget.onChanged,
          name: widget.name,
          style: TextStyle(color: Palette.lightPurple),
          decoration: InputDecoration(
            labelText: widget.labelText ?? "",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Palette.lightPurple,
            ),
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            ),
          ),
        ),
      ),
    );
  }
}
