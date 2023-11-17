import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/utils/icons.dart';

import '../utils/colors.dart';

class MyFormBuilderTextField extends StatefulWidget {
  String name;
  String? hintText;
  Color? fillColor;
  bool? obscureText;
  double? width;
  double? height;
  double? borderRadius;
  MyFormBuilderTextField({
    Key? key,
    required this.name,
    this.hintText,
    this.fillColor,
    this.obscureText,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<MyFormBuilderTextField> createState() => _MyFormBuilderTextFieldState();
}

class _MyFormBuilderTextFieldState extends State<MyFormBuilderTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FormBuilderTextField(
        name: widget.name,
        style: TextStyle(color: Palette.darkPurple),
        obscuringCharacter: '✮',
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
            //labelText: widget.labelText ?? "",
            hintText: widget.hintText ?? "",
            hintStyle: TextStyle(height: 1, fontWeight: FontWeight.w400),
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0))),
      ),
    );
  }
}
