import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/colors.dart';

class MyFormBuilderFilterChip extends StatefulWidget {
  String? name;
  List<FormBuilderFieldOption<dynamic>>? options;
  String? labelText;
  final List<dynamic>? initialValue;
  void Function(List<dynamic>?)? onChanged;

  /// Width of FormBuilderFilterChip
  double? width;

  /// Height of FormBuilderFilterChip
  double? height;

  /// Label font size
  double? fontSize;

  /// Shows checkmark when selected, true by default
  bool? showCheckmark;

  /// Refers to padding of each individual chip
  EdgeInsets? padding;

  MyFormBuilderFilterChip({
    Key? key,
    required this.name,
    required this.options,
    this.labelText,
    this.initialValue,
    this.onChanged,
    this.width,
    this.height,
    this.fontSize,
    this.showCheckmark = true,
    this.padding,
  }) : super(key: key);

  @override
  State<MyFormBuilderFilterChip> createState() =>
      _MyFormBuilderFilterChipState();
}

class _MyFormBuilderFilterChipState extends State<MyFormBuilderFilterChip> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FormBuilderFilterChip(
        padding: widget.padding,
        name: widget.name!,
        initialValue: widget.initialValue ?? [],
        showCheckmark: widget.showCheckmark ?? true,
        options: widget.options!,
        decoration: InputDecoration(
          labelText: widget.labelText ?? "",
          contentPadding: EdgeInsets.zero,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          fillColor: Colors.transparent,
          labelStyle: TextStyle(
            fontSize: widget.fontSize ?? 0,
            fontWeight: FontWeight.w500,
            color: Palette.lightPurple,
            height: 0.2,
          ),
          border: InputBorder.none,
        ),
        onChanged: widget.onChanged,
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 0,
      ),
    );
  }
}
