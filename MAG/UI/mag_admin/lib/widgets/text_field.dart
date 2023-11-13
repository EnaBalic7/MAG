import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  String? labelText;
  MyTextField({Key? key, this.labelText}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(decoration: InputDecoration(labelText: widget.labelText));
  }
}
