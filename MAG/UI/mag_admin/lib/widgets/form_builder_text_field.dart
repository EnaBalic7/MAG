import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/utils/icons.dart';

import '../utils/colors.dart';

class MyFormBuilderTextField extends StatefulWidget {
  String name;
  String? labelText;
  Color? fillColor;
  bool? obscureText;
  double? width;
  double? height;
  bool? readOnly;
  double? borderRadius;
  TextInputType? keyboardType;
  String? initialValue;
  int? maxLines;
  double? paddingLeft;
  double? paddingRight;
  double? paddingTop;
  double? paddingBottom;
  void Function(String?)? onChanged;
  MyFormBuilderTextField({
    Key? key,
    required this.name,
    this.labelText,
    this.fillColor,
    this.obscureText,
    this.width,
    this.height,
    this.borderRadius,
    this.readOnly,
    this.keyboardType,
    this.initialValue,
    this.maxLines = 1,
    this.paddingLeft = 40,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 50,
    this.onChanged,
  }) : super(key: key);

  @override
  State<MyFormBuilderTextField> createState() => _MyFormBuilderTextFieldState();
}

class _MyFormBuilderTextFieldState extends State<MyFormBuilderTextField> {
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
        child: FormBuilderTextField(
          onChanged: widget.onChanged,
          maxLines: _maxLines(),
          keyboardType: widget.keyboardType ?? TextInputType.text,
          readOnly: widget.readOnly ?? false,
          name: widget.name,
          style: TextStyle(color: Palette.lightPurple),
          obscuringCharacter: '✮',
          obscureText: widget.obscureText ?? false,
          decoration: InputDecoration(
            labelText: widget.labelText ?? "",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Palette.lightPurple,
            ),
            fillColor: _fillColor(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            ),
          ),
        ),
      ),
    );
  }

  int? _maxLines() {
    if (widget.maxLines == null) {
      return null;
    }
    return widget.maxLines;
  }

  Color? _fillColor() {
    if (widget.readOnly == true) {
      return Palette.disabledControl;
    }
    return widget.fillColor;
  }
}
