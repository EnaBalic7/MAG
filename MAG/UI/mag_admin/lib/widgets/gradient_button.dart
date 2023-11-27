import 'package:flutter/material.dart';

import '../utils/colors.dart';

class GradientButton extends StatefulWidget {
  void Function()? onPressed;
  double? width;
  double? height;
  double? borderRadius;
  LinearGradient? gradient;
  Widget? child;
  GradientButton({
    Key? key,
    this.onPressed,
    this.width = 0,
    this.height = 0,
    this.borderRadius = 0,
    this.gradient,
    this.child,
  }) : super(key: key);

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(widget.width!, widget.height!),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0))),
        child: Ink(
            decoration: BoxDecoration(
                border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0)),
            child: Container(
                width: widget.width,
                height: widget.height,
                alignment: Alignment.center,
                child: widget.child)));
  }
}
