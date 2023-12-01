import 'package:flutter/material.dart';

import '../utils/colors.dart';

class GradientButton extends StatefulWidget {
  void Function()? onPressed;
  double? width;
  double? height;
  double? borderRadius;
  LinearGradient? gradient;
  Widget? child;
  double? paddingLeft;
  double? paddingRight;
  double? paddingTop;
  double? paddingBottom;
  GradientButton({
    Key? key,
    this.onPressed,
    this.width = 0,
    this.height = 0,
    this.borderRadius = 0,
    this.gradient,
    this.child,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 0,
  }) : super(key: key);

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.paddingLeft!,
          right: widget.paddingRight!,
          top: widget.paddingTop!,
          bottom: widget.paddingBottom!),
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(widget.width!, widget.height!),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 0))),
          child: Ink(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Palette.lightPurple.withOpacity(0.3)),
                  gradient: widget.gradient,
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 0)),
              child: Container(
                  width: widget.width,
                  height: widget.height,
                  alignment: Alignment.center,
                  child: widget.child))),
    );
  }
}
