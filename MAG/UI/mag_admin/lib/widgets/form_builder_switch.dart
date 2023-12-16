import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/colors.dart';

class MyFormBuilderSwitch extends StatefulWidget {
  String name;
  Widget title;
  Widget? subtitle;

  MyFormBuilderSwitch({
    Key? key,
    required this.name,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  State<MyFormBuilderSwitch> createState() => _MyFormBuilderSwitchState();
}

class _MyFormBuilderSwitchState extends State<MyFormBuilderSwitch> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderSwitch(
      name: widget.name,
      title: widget.title,
      subtitle: widget.subtitle ?? Text(""),
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      activeColor: Palette.teal,
    );
  }
}
