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
  Color? dropdownColor;
  double? width;
  double? height;
  double? borderRadius;
  String? initialValue;
  double? paddingLeft;
  double? paddingRight;
  double? paddingTop;
  double? paddingBottom;
  Widget? icon;
  void Function(String?)? onChanged;
  List<DropdownMenuItem<String>> items;
  MyFormBuilderDropdown({
    Key? key,
    required this.name,
    this.labelText,
    this.fillColor,
    this.dropdownColor,
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
    required this.items,
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
          dropdownColor: widget.dropdownColor ?? Palette.darkPurple,
          items: widget.items,
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
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            ),
          ),
        ),
      ),
    );
  }
}
