import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
  double? borderWidth;
  Color? borderColor;
  TextInputType? keyboardType;
  String? initialValue;
  int? maxLines;
  int? minLines;
  double? paddingLeft;
  double? paddingRight;
  double? paddingTop;
  double? paddingBottom;
  void Function(String?)? onChanged;
  String? Function(String?)? validator;
  void Function(String?)? onSubmitted;
  void Function(String?)? onSaved;
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
    this.minLines = 1,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.onChanged,
    this.validator,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.onSubmitted,
    this.onSaved,
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
          textAlignVertical: TextAlignVertical.top,
          focusNode: FocusNode(),
          initialValue: widget.initialValue,
          minLines: widget.minLines,
          autovalidateMode: AutovalidateMode.always,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onSaved: widget.onSaved,
          maxLines: _maxLines(),
          keyboardType: widget.keyboardType ?? TextInputType.text,
          readOnly: widget.readOnly ?? false,
          name: widget.name,
          style: const TextStyle(
            color: Palette.lightPurple,
          ),
          obscuringCharacter: '✮',
          obscureText: widget.obscureText ?? false,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              borderSide: BorderSide(
                color: widget.borderColor!,
                width: widget.borderWidth ?? 0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Palette.lightRed),
                borderRadius: BorderRadius.circular(50)),
            errorStyle: const TextStyle(color: Palette.lightRed, height: 0.5),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Palette.lightRed),
                borderRadius: BorderRadius.circular(50)),
            labelText: widget.labelText ?? "",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Palette.lightPurple,
            ),
            fillColor: _fillColor(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              borderSide: BorderSide(
                color: widget.borderColor!,
                width: widget.borderWidth ?? 0,
              ),
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
