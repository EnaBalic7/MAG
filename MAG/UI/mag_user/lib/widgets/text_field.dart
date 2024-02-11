import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MyTextField extends StatefulWidget {
  String? hintText;
  Color? fillColor;
  bool? obscureText;
  double? width;
  double? height;
  double? borderRadius;
  TextEditingController? controller;
  TextInputType keyboardType;
  MyTextField({
    Key? key,
    this.hintText,
    this.fillColor,
    this.obscureText,
    this.width,
    this.height,
    this.borderRadius,
    this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(color: Palette.lightPurple),
        obscuringCharacter: '✮',
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
            hintText: widget.hintText ?? "",
            hintStyle: const TextStyle(
                height: 2.8,
                fontWeight: FontWeight.w400,
                color: Palette.lightPurple),
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0))),
      ),
    );
  }
}
