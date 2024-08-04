import 'package:flutter/material.dart';

import '../utils/colors.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  String? hintText;
  Color? fillColor;
  bool? obscureText;
  double? width;
  double? height;
  double? borderRadius;
  TextEditingController? controller;
  MyTextField(
      {Key? key,
      this.hintText,
      this.fillColor,
      this.obscureText,
      this.width,
      this.height,
      this.borderRadius,
      this.controller})
      : super(key: key);

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
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
            hintText: widget.hintText ?? "",
            hintStyle: const TextStyle(
                height: 0,
                fontWeight: FontWeight.w400,
                color: Palette.lightPurple),
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0))),
      ),
    );
  }
}
